#!/bin/bash

# A script that sets permissions for use on the web server

# verify this script is running in an acceptable directory
if [ $(pwd) = "/" ]; then
  echo "error: the working directory cannot be the root dir"
  exit 1
fi
if [ ! -d "./REST" ]; then
  echo "error: expected directory not present"
  exit 1
fi

# set group of all files to www-data
chown -R :www-data .

# media directory
chown -R :www-data REST/media
chmod -R g+w REST/media

echo "done applying permissions"
