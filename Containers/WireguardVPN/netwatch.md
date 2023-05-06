# mikrotik netwatch up / down script

# up

/ip firewall nat set [find comment="VPN"] to-addresses=xx.xx.xx.xx

# down

/ip firewall nat set [find comment="VPN"] to-addresses=xx.xx.xx.xx
