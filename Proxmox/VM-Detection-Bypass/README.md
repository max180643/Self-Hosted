# VM Detection Bypass

1.1 edit vm config
`nano /etc/pve/qemu-server/<vmid>.conf`
1.2 add this line
`args: -cpu 'host,-hypervisor,+kvm_pv_unhalt,+kvm_pv_eoi,hv_spinlocks=0x1fff,hv_vapic,hv_time,hv_reset,hv_vpindex,hv_runtime,hv_relaxed,kvm=off,hv_vendor_id=intel'`

#### References

- [Genshin Impact VM gaming](https://www.reddit.com/r/Proxmox/comments/j4lhph/genshin_impact_vm_gaming/)
