# CHNWT-Proxmox

| Application         | Port number               | Port mapping | Namespace         |
| ------------------- | ------------------------- | ------------ | ----------------- |
| Proxmox             | 8006 (Web UI), 22 (SSH)   | -            | CubeServer (Node) |
| Cloudflare DDNS     | -                         | -            | Gateway (VM)      |
| Nginx Proxy Manager | 80, 81 (Web UI), 443      | 8010:81      | Gateway (VM)      |
| WireGuard VPN       | 51820/udp, 51821 (Web UI) | 8020:51821   | Gateway (VM)      |
