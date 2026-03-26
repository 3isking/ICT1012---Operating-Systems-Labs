//
// File-system system calls.
// Mostly argument checking, since we don't trust
// user code, and calls into file.c and fs.c.
//

#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "spinlock.h"
#include "proc.h"
#include "fs.h"
#include "sleeplock.h"
#include "file.h"
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  int fd;
  struct file *f;

  argint(n, &fd);
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *p = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(p->ofile[fd] == 0){
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}

uint64
sys_dup(void)
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}

uint64
sys_read(void)
{
  struct file *f;
  int n;
  uint64 p;

  argaddr(1, &p);
  argint(2, &n);
  if(argfd(0, 0, &f) < 0)
    return -1;
  return fileread(f, p, n);
}

uint64
sys_write(void)
{
  struct file *f;
  int n;
  uint64 p;
  
  argaddr(1, &p);
  argint(2, &n);
  if(argfd(0, 0, &f) < 0)
    return -1;

  return filewrite(f, p, n);
}

uint64
sys_close(void)
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}

uint64
sys_fstat(void)
{
  struct file *f;
  uint64 st; // user pointer to struct stat

  argaddr(1, &st);
  if(argfd(0, 0, &f) < 0)
    return -1;
  return filestat(f, st);
}

// Create the path new as a link to the same inode as old.
uint64
sys_link(void)
{
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;

  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
  iput(ip);

  end_op();

  return 0;

bad:
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
}

uint64
sys_unlink(void)
{
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;

  if(argstr(0, path, MAXPATH) < 0)
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
    return -1;
  }

  ilock(dp);

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);

  end_op();

  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;

  ilock(dp);

  if((ip = dirlookup(dp, name, 0)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0){
    iunlockput(dp);
    return 0;
  }

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      goto fail;
  }

  if(dirlink(dp, name, ip->inum) < 0)
    goto fail;

  if(type == T_DIR){
    // now that success is guaranteed:
    dp->nlink++;  // for ".."
    iupdate(dp);
  }

  iunlockput(dp);

  return ip;

 fail:
  // something went wrong. de-allocate ip.
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}

uint64
sys_open(void)
{
  char path[MAXPATH];
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
  if((n = argstr(0, path, MAXPATH)) < 0)
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);

    /*
    ---------------- IMPLEMENTATION OF SYMBOLIC LINKS ----------------
    */


    // Depth Counter to Keep Track of How Many Symbolic Links Passed
    int depth = 0;
    char linkpath[MAXPATH];

    // Check if the Inode is a SYMLINK and there is no NOFOLLOW flag set
    while (ip->type == T_SYMLINK && !(omode & O_NOFOLLOW)) {
      // If 10 redirects are created, Transaction is dropped
      if (depth >= 10) {
        iunlockput(ip);
        end_op();
        return -1;  // too many levels of symlinks
      }

      // Read the target path stored in the symlink's data
      int n = readi(ip, 0, (uint64)linkpath, 0, MAXPATH);
      if (n <= 0) {
        iunlockput(ip);
        end_op();
        return -1;
      }
      linkpath[n] = '\0';

      // Release the current SYSLINK Inode to later replace with the real inode
      iunlockput(ip);  

      // FInd the Real File's Inode w/ File Path
      ip = namei(linkpath);

      // If the Real File Cannot be found, it is a Dangling Link
      // Return -1
      if (ip == 0) {
        end_op();
        return -1;
      }

      // Lock the new Inode & increment the depth
      ilock(ip);
      depth++;
    }

    if(ip->type == T_DIR && omode != O_RDONLY){
      iunlockput(ip);
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    f->off = 0;
  }
  f->ip = ip;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);

  if((omode & O_TRUNC) && ip->type == T_FILE){
    itrunc(ip);
  }

  iunlock(ip);
  end_op();

  return fd;
}

uint64
sys_mkdir(void)
{
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}

uint64
sys_mknod(void)
{
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
  argint(1, &major);
  argint(2, &minor);
  if((argstr(0, path, MAXPATH)) < 0 ||
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}

uint64
sys_chdir(void)
{
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
  
  begin_op();
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
  iput(p->cwd);
  end_op();
  p->cwd = ip;
  return 0;
}

uint64
sys_exec(void)
{
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
  if(argstr(0, path, MAXPATH) < 0) {
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv)){
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
      goto bad;
    }
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    if(argv[i] == 0)
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
      goto bad;
  }

  int ret = exec(path, argv);

  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    kfree(argv[i]);
  return -1;
}

uint64
sys_pipe(void)
{
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();

  argaddr(0, &fdarray);
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    p->ofile[fd0] = 0;
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
}

uint64
sys_symlink(void)
{
  char target[MAXPATH], path[MAXPATH];
  struct inode *ip;

  // ArgStr used to get Syscall Arugments
  // One is for the Target variable and the other is for Path
  // If either one is empty, return -1
  if(argstr(0, target, MAXPATH) < 0 || argstr(1, path, MAXPATH) < 0)
    return -1;

  // Begin a Transaction (necessary to do a write to prevent crashes)
  begin_op();

  // Create an Symlink Inode
  // The Inode is locked on creation
  // If it does not create successfully, end the Transaction and return -1
  if((ip = create(path, T_SYMLINK, 0, 0)) == 0){
    end_op();
    return -1;
  }

  // Write the target path onto the Symlink Inode
  // When Symlink Inode is opened, the contained path is referenced
  // If the write is unsuccessful, end the Transaction and return -1
  if(writei(ip, 0, (uint64)target, 0, strlen(target)) < 0){
    iunlockput(ip);
    end_op();
    return -1;
  }

  // Unlock the Inode & End the Transaction
  iunlockput(ip);
  end_op();

  return 0;
}

// TRIPLE INDIRECT
// bn -= NDINDIRECT;   // subtract doubly-indirect range first

// if(bn < NTINDIRECT){

//     // ── LEVEL 1: get or allocate the L1 master map ──────────────────
//     // ip->addrs[NDIRECT+2] is the triply-indirect slot in the inode
//     if((addr = ip->addrs[NDIRECT+2]) == 0){
//         addr = balloc(ip->dev);
//         if(addr == 0)
//             return 0;
//         ip->addrs[NDIRECT+2] = addr;
//     }

//     // load L1 map into memory
//     bp = bread(ip->dev, addr);
//     a = (uint*)bp->data;

//     // calculate which L2 map we need
//     uint idx1 = bn / (NINDIRECT * NINDIRECT);

//     // get or allocate the L2 map
//     if((addr = a[idx1]) == 0){
//         addr = balloc(ip->dev);
//         if(addr){
//             a[idx1] = addr;
//             log_write(bp);      // L1 map was modified
//         }
//     }
//     brelse(bp);                 // done with L1 — release immediately
//     if(addr == 0)
//         return 0;

//     // ── LEVEL 2: get or allocate the L2 map ─────────────────────────
//     bp = bread(ip->dev, addr);
//     a = (uint*)bp->data;

//     // calculate which L3 map we need
//     uint idx2 = (bn / NINDIRECT) % NINDIRECT;

//     // get or allocate the L3 map
//     if((addr = a[idx2]) == 0){
//         addr = balloc(ip->dev);
//         if(addr){
//             a[idx2] = addr;
//             log_write(bp);      // L2 map was modified
//         }
//     }
//     brelse(bp);                 // done with L2 — release immediately
//     if(addr == 0)
//         return 0;

//     // ── LEVEL 3: get or allocate the L3 map ─────────────────────────
//     bp = bread(ip->dev, addr);
//     a = (uint*)bp->data;

//     // calculate which data block we need
//     uint idx3 = bn % NINDIRECT;

//     // get or allocate the actual data block
//     if((addr = a[idx3]) == 0){
//         addr = balloc(ip->dev);
//         if(addr){
//             a[idx3] = addr;
//             log_write(bp);      // L3 map was modified
//         }
//     }
//     brelse(bp);                 // done with L3 — release immediately
//     return addr;
// }
// ---

// ## The pattern you can apply to any number of levels

// Every level follows exactly the same four steps:

// 1. check if addr slot is 0 → balloc if so → save it back → log_write if it was a map block
// 2. bread that addr to load the map
// 3. calculate the index for THIS level
// 4. brelse the map immediately after getting the next addr
// The only things that change between levels are which slot you save the address into, and the index formula. Here is how the index formula scales:

// singly:   index = bn
// doubly:   idx1  = bn / 256
//           idx2  = bn % 256
// triply:   idx1  = bn / (256 × 256)
//           idx2  = (bn / 256) % 256
//           idx3  = bn % 256


/*
sys_link(void)
{
  char old[MAXPATH], new[MAXPATH];
  char name[DIRSIZ];
  struct inode *ip, *dp;

  // Fetch arguments: link(old, new)
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    return -1;

  begin_op();  // start filesystem operation

  // Get inode of existing file (old)
  if((ip = namei(old)) == 0){
    end_op();
    return -1;
  }

  ilock(ip);

  // Disallow linking directories (prevents cycles)
  if(ip->type == T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
  }

  // Increment link count (another name pointing to same inode)
  ip->nlink++;
  iupdate(ip);   // write updated inode to disk
  iunlock(ip);

  // Find parent directory of new path
  if((dp = nameiparent(new, name)) == 0)
    goto bad;

  ilock(dp);

  // Create new directory entry: name → ip->inum
  if(dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
    goto bad;
  }

  iunlockput(dp);
  iput(ip);

  end_op();
  return 0;

bad:
  // Rollback if linking failed
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);

  end_op();
  return -1;
}

*/