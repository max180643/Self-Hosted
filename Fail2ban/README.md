# Fail2ban

### Setup Fail2ban

**Step 1:** Update and upgrade packages

```bash
$ sudo apt update
$ sudo apt upgrade
```

**Step 2:** Install Fail2ban

```bash
$ sudo apt install fail2ban
```

**Step 3:** Create configuration

```bash
$ sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```

### Enable SSH Protection

**Step 1:** Edit configuration

```bash
$ sudo nano /etc/fail2ban/jail.local
```

**Step 2:** use `CTRL` + `W` key combination to search for "`[sshd]`", it should look like this

```properties
[sshd]

port    = ssh
logpath = %(sshd_log)s
backend = %(sshd_backend)s
```

**Step 3:** Edit configuration like this

```properties
[sshd]

enabled = true
port    = ssh
logpath = %(sshd_log)s
backend = %(sshd_backend)s
filter  = sshd
banaction = iptables-multiport
maxretry = 3
bantime = 86400
```

**Step 4:** Save configuration file
Press `CTRL` + `X` then `Y` and finally `ENTER`

**Step 5:** Restart Fail2ban to reload configuration

```bash
$ sudo service fail2ban restart
```

### Enable Proxmox Protection

**Step 1:** Create Proxmox configuration

```bash
$ sudo nano /etc/fail2ban/filter.d/proxmox.conf
```

Then add configuration like this

```properties
[Definition]
failregex = pvedaemon\[.*authentication failure; rhost=<HOST> user=.* msg=.*
ignoreregex =
```

**Step 2:** Save configuration file
Press `CTRL` + `X` then `Y` and finally `ENTER`

**Step 3:** Edit configuration
Add this string to the end of this file

```properties
[proxmox]
enabled = true
port = https,http,8006
filter = proxmox
logpath = /var/log/daemon.log
maxretry = 3
bantime = 86400
```

**Step 4:** Save configuration file
Press `CTRL` + `X` then `Y` and finally `ENTER`

**Step 5:** Restart Fail2ban to reload configuration

```bash
$ sudo service fail2ban restart
```
