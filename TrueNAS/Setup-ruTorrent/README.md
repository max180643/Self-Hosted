# Setup ruTorrent on TrueNAS Scale

### Setup ruTorrent

**Step 1:** Create storage pool

**Step 2:** Create datasets

**Step 3:** Create folder for ruTorrent config

- Use Shell to create folder

```bash
$ sudo mkdir ruTorrent
```

- Create config folder

```bash
$ mkdir config
```

**Step 4:** Launch ruTorrent Application

- Click "Apps" on left panel
- Then click "Launch Docker Image" button
- On Application Name Tab -> Enter "rutorrent" in Application Name
- On Container Images Tab -> Enter "crazymax/rtorrent-rutorrent" in Image repository

- On Container Environment Variables Tab -> Click "Add" button x5 time at Container Environment Variables
- First box for TimeZone -> Enter "TZ" in Environment Variable Name and "Asia/Bangkok" in Environment Variable Value
- Second box for ruTorrent HTTP port (Web GUI) -> Enter "RUTORRENT_PORT" in Environment Variable Name and "9090" in Environment Variable Value
- Third box for DHT UDP port -> Enter "RT_DHT_PORT" in Environment Variable Name and "10881" in Environment Variable Value
- Fourth box for Incoming connections port -> Enter "RT_INC_PORT" in Environment Variable Name and "10881" in Environment Variable Value
- Five box for XMLRPC port through nginx over SCGI socket -> Enter "XMLRPC_PORT" in Environment Variable Name and "10000" in Environment Variable Value

- On Port Forwarding Tab -> Click "Add" button x4 time at Specify Node ports to forward to workload
- First box for ruTorrent HTTP port (Web GUI) -> Enter "9090" in Container Port and Node Port and Select TCP Protocol
- Second box for DHT UDP port -> Enter "10881" in Container Port and Node Port and Select UDP Protocol
- Third box for Incoming connections port -> Enter "10881" in Container Port and Node Port and Select TCP Protocol
- Fourth box for XMLRPC port through nginx over SCGI socket -> Enter "10000" in Container Port and Node Port and Select TCP Protocol

- On Storage Tab -> Click "Add" button x3 time at Host Path Volumes
- First box for config directory path mapping -> Select your directory at Host Path and Mount Path enter "/data"
- Second box for downloads directory path mapping -> Select your directory at Host Path and Mount Path enter "/downloads"
- Third box for htpasswd directory path mapping -> Select your directory at Host Path and Mount Path enter "/passwd"
- Then click on "Save" button at bottom and wait application "ACTIVE" status

**Step 5:** Config ruTorrent username and password

Htpasswd Type:

- `rpc.htpasswd`: XMLRPC through nginx

- `rutorrent.htpasswd`: ruTorrent basic auth (Web GUI)

- `webdav.htpasswd`: WebDAV on completed downloads

You can populate `.htpasswd` files with the following command

- Use Shell (not container shell) to create the Password File Using htpasswd

```bash
$ sudo htpasswd -c ${HTPASSWD_DIRECTORY}/${TYPE}.htpasswd ${USERNAME}
```

- Then "Stop" and "Start" ruTorrent Application
