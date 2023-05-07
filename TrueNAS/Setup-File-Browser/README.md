# Setup File Browser on TrueNAS Scale

### Setup File Browser

**Step 1:** Create storage pool

**Step 2:** Create datasets

**Step 3:** Create folder for File Browser database and config

- Use Shell to create folder

```bash
$ sudo mkdir FileBrowser
```

- Create database file

```bash
$ sudo touch database.db
```

- Create config file

```bash
$ sudo nano config.json
```

- Add this config and save file

```json
{
  "port": 80,
  "baseURL": "",
  "address": "",
  "log": "stdout",
  "database": "/database.db",
  "root": "/storage"
}
```

**Step 4:** Launch File Browser Application

- Click "Apps" on left panel
- Then click "Launch Docker Image" button
- On Application Name Tab -> Enter "filebrowser" in Application Name
- On Container Images Tab -> Enter "filebrowser/filebrowser" in Image repository
- On Port Forwarding Tab -> Click "Add" button -> Enter "80" in Container Port and "<access_port>" in Node Port and Select TCP Protocol
- On Storage Tab -> Click "Add" button x3 time at Host Path Volumes
- First box for storage directory path mapping -> Select your directory at Host Path and Mount Path enter "/storage"
- Second box for database file path mapping -> Select your database file at Host Path and Mount Path enter "/database.db"
- Third box for config file path mapping -> Select your config file at Host Path and Mount Path enter "/.filebrowser.json"
- Then click on "Save" button at bottom and wait application "ACTIVE" status

**Step 5:** Change File Browser Default username and password

- Enter "<truenas_ip>:<access_port>" in Browser
- Enter "admin" in Username and "admin" in Password then click "Login" button
- Click "Settings" on left panel and click "User Management"
- Edit your username and password then click "SAVE" button
