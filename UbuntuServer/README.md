# Ubuntu Server

### Setup static ip address (Network configuration)

```properties
Subnet 192.168.0.0/24
Address 192.168.0.232
Gateway 192.168.0.1
NameServers 8.8.8.8,1.1.1.1
SearchDomains example.local
```

### Update and Upgrade Package

```bash
$ sudo apt update
$ sudo apt upgrade
```

### Setup Docker

**Step 1:** Set up Docker's apt repository

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

**Step 2:** Install the Docker packages

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

**Step 3:** Fix permission denied while trying to connect to the Docker daemon socket
3.1 Create the docker group

```bash
sudo groupadd docker
```

3.2 Add your user to the docker group

```bash
sudo usermod -aG docker $USER
```
