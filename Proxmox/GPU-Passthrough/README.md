# Proxmox GPU Passthrough to VM (My Config)

## Configuring Proxmox

SSH directly into your Proxmox server

Step 1: Configuring the Grub
1.1

```bash
$ nano /etc/default/grub
```

1.2 Edit this line
Old:

```properties
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
```

New :

```properties
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt pcie_acs_override=downstream,multifunction nofb nomodeset video=vesafb:off,efifb:off"
```

1.3

```bash
$ update-grub
```

Step 2: VFIO Modules
2.1

```bash
$ nano /etc/modules
```

2.2 Add the following

```properties
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
```

Step 3: IOMMU interrupt remapping

```bash
$ echo "options vfio_iommu_type1 allow_unsafe_interrupts=1" > /etc/modprobe.d/iommu_unsafe_interrupts.conf
$ echo "options kvm ignore_msrs=1" > /etc/modprobe.d/kvm.conf
```

Step 4: Blacklisting Drivers

```bash
$ echo "blacklist radeon" >> /etc/modprobe.d/blacklist.conf
$ echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
$ echo "blacklist nvidia" >> /etc/modprobe.d/blacklist.conf
$ echo "blacklist nvidiafb" >> /etc/modprobe.d/blacklist.conf
```

Step 5: Adding GPU to VFIO
5.1 Find GPU Set of numbers

```bash
$ lspci -v
```

```properties
02:00.0 VGA compatible controller: NVIDIA Corporation GP102 [GeForce GTX 1080 Ti] (rev a1) (prog-if 00 [VGA controller])
	Subsystem: Micro-Star International Co., Ltd. [MSI] GP102 [GeForce GTX 1080 Ti]
	Physical Slot: 1
	Flags: bus master, fast devsel, latency 0, IRQ 26, IOMMU group 80
	Memory at c6000000 (32-bit, non-prefetchable) [size=16M]
	Memory at b0000000 (64-bit, prefetchable) [size=256M]
	Memory at c0000000 (64-bit, prefetchable) [size=32M]
	I/O ports at 7000 [size=128]
	Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 3
	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [78] Express Legacy Endpoint, MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting <?>
	Capabilities: [420] Advanced Error Reporting
	Capabilities: [600] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
	Capabilities: [900] Secondary PCI Express
	Kernel driver in use: vfio-pci
	Kernel modules: nvidiafb, nouveau

02:00.1 Audio device: NVIDIA Corporation GP102 HDMI Audio Controller (rev a1)
	Subsystem: Micro-Star International Co., Ltd. [MSI] GP102 HDMI Audio Controller
	Physical Slot: 1
	Flags: bus master, fast devsel, latency 0, IRQ 43, IOMMU group 81
	Memory at c7080000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [60] Power Management version 3
	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [78] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Kernel driver in use: vfio-pci
	Kernel modules: snd_hda_intel
```

5.2 Get vendor id

```bash
$ lspci -n -s 02:00
```

```properties
02:00.0 0300: 10de:1b06 (rev a1)
02:00.1 0403: 10de:10ef (rev a1)
```

5.3 Add the GPU's vendor id's to the VFIO

```bash
$ echo "options vfio-pci ids=10de:1b06,10de:10ef disable_vga=1"> /etc/modprobe.d/vfio.conf
```

5.4

```bash
$ update-initramfs -u
```

5.5

```bash
$ reset
```

5.6

```bash
$ reboot -f
```

## Configuring the VM

Step 1: Create a VM [Disk - SCSI, Machine - q35, Network - VirtIO] ([VirtIO drivers](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso))

Step 2: Enable OMVF (UEFI) for the VM (Add EFI, TPM)

Step 3: Edit the VM Config File
3.1

```bash
nano /etc/pve/qemu-server/<vmid>.conf
```

3.2 add this

```properties
cpu: host,hidden=1,flags=+pcid
```

Step 4: Add PCI Devices (Your GPU) to VM (From Web UI)
4.1 config details

```properties
All Functions: YES
Rom-Bar: YES
Primary GPU: YES
PCI-Express: YES (requires 'machine: q35' in vm config file)
```

4.2 upload rom

```bash
$ scp /path/to/<romfilename>.rom myusername@proxmoxserveraddress:/usr/share/kvm/<romfilename>.rom
```

4.3 edit config

```bash
$ nano /etc/pve/qemu-server/<vmid>.conf
```

4.4 add romfile

```properties
hostpci0: 02:00,pcie=1,romfile=<GTX1080ti_Patch>.rom
```

Step 5: START THE VM!
**Method 1:**
5.1 Connect Monitor to GPU
5.2 Mapping mouse / keyboard to VM
5.3 Edit GPU PCI Devices -> Enable Primary GPU
5.4 Start OS -> Install GPU Driver
5.5 Reboot VM
**Method 2 (Headless):**
5.1 Setup Remote Desktop -> Shutdown OS
5.2 Set Display `Default` -> `None`
5.3 Start OS -> Install GPU Driver (Connect from Remote Desktop)
5.4 Edit GPU PCI Devices -> Enable Primary GPU
5.5 Reboot VM

#### References

- [The Ultimate Beginner's Guide to GPU Passthrough (Proxmox, Windows 10) - Reddit
  ](https://www.reddit.com/r/homelab/comments/b5xpua/the_ultimate_beginners_guide_to_gpu_passthrough/)
- [Ultimate Beginner's Guide to Proxmox GPU Passthrough - Gist](https://gist.github.com/qubidt/64f617e959725e934992b080e677656f)
- [GPU passthrough on single GPU systems troubleshooting](https://www.reddit.com/r/Proxmox/comments/1118opd/psa_gpu_passthrough_on_single_gpu_systems/)
- [Configure Proxmox GPU Passthrough (Step-by-Step Tutorial)](https://www.youtube.com/watch?v=IE0ew8WwxLM)
