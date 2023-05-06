#!/bin/bash

# Define variables
REMOTE_SERVER="root@remote-server.com"
REMOTE_DIRECTORY="/path/to/remote/directory"
LOCAL_DIRECTORY="/path/to/local/directory"

# Transfer files
scp -r $LOCAL_DIRECTORY/* $REMOTE_SERVER:$REMOTE_DIRECTORY

# Permission Deny
# chmod -R 777 folder_path