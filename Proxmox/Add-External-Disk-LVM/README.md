# Add External Disk - LVM

### Setup External Disk

**Step 1:** Insert External Disk to Node

**Step 2:** Open Proxmox Web UI

From Proxmox dashboard, go to <strong>Node -> Disk</strong>

**Step 3:** Format External Disk

Select <strong>External Disk</strong> then click <strong>"Wipe Disk"</strong> button

**Step 4:** Format to GPT partition

Click <strong>"Shell"</strong> button then type <strong>"sgdisk -N 1 {device path: ex. /dev/sda}"</strong> and enter

**Step 5:** Create LVM-Thin Pool

Go to <strong>Disk -> LVM-Thin</strong> click <strong>"Create Thinpool"</strong> button

**Step 6:**

Select <strong>External Disk</strong>, Enter <strong>Storage name</strong> and Check on <strong>"add storage"</strong> Checkbox, Done.
