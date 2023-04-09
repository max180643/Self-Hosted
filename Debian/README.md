# Debian

### Install Package

```bash
$ apt update
$ apt upgrade
```

**Nano (Text editor)**

```bash
$ apt install nano
```

**Git**

```bash
$ apt install git
```

### Setup Sudo

**Step 1:** Install sudo package

```bash
$ apt install sudo
```

**Step 2:** Add User to the Sudo Group

```bash
$ usermod -aG sudo [username]
```

### Setup static IP address

**Step 1:** Backup /etc/network/interfaces file

```bash
$ sudo cp /etc/network/interfaces /root/
```

**Step 2:** Edit the /etc/network/interfaces file

```bash
$ sudo nano /etc/network/interfaces
```

**Step 3:** Look for the primary network (Example: ens18 Ethernet interface)
Then append the following configuration. My sample config file

```properties
# The primary network interface
allow-hotplug ens18
iface ens18 inet static
address 192.168.1.233
netmask 255.255.255.0
gateway 192.168.1.1
dns-nameservers 192.168.1.1 1.1.1.1
```

**Step 4:** Save configuration file
Press `CTRL` + `X` then `Y` and finally `ENTER`

**Step 5:** Restart networking service
Method 1:

```bash
$ sudo systemctl restart networking.service
```

Method 2:

```bash
$ sudo reboot -f
```

### Setup Fail2ban

[Follow this guide](../Fail2ban/README.md)

### Setup Docker

**Step 1:** Set up the repository
1.1 Update the `apt` package index and install packages to allow `apt` to use a repository over HTTPS

```bash
$ sudo apt-get update
$ sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

1.2 Add Docker’s official GPG key

```bash
$ sudo mkdir -m 0755 -p /etc/apt/keyrings
$ curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

1.3 Use the following command to set up the repository

```bash
$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

**Step 2:** Install Docker Engine
2.1 Update the `apt` package index

```bash
$ sudo apt-get update
```

2.2 Install Docker Engine, containerd, and Docker Compose

```bash
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

**Step 3:** Fix permission denied while trying to connect to the Docker daemon socket
3.1 Create the docker group

```bash
$ sudo groupadd docker
```

3.2 Add your user to the docker group

```bash
$ sudo usermod -aG docker [username]
```
