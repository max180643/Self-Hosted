# Passthrough Physical Disk or USB to VM

### Passthrough Disk to a Proxmox Virtual Machine

Proxmox Web interface allows you can add only USB disks or flash drives to the virtual machine, To pass a physical hard disk (passthrough mode) to a Proxmox virtual machine, you must use the hypervisor shell.

**Command syntax**

```bash
$ qm set <vm_id> -[virtio2|sata|ide|scsi] <disk_path>
```

#### How to get Disk Path

**Method 1 - By UUID:**

1. Find UUID from mount path

```bash
$ blkid /dev/sdb1
```

2. Get disk path

```bash
<disk_path> = /dev/disk/by-uuid/<UUID>
```

**Method 2 - By ID:**

1. Find Disk ID from Serial

```bash
$ ls -l /dev/disk/by-id | grep <Serial>
```

2. Get disk path

```bash
<disk_path> = /dev/disk/by-id/<disk_id>
```

#### References

- [Passthrough Physical Disk or USB to VM on Proxmox VE](https://poweradm.com/passthrough-disk-vm-proxmox/)
