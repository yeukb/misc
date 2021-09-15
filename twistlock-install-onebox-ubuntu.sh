#!/bin/bash

# Required Parameters
USERNAME=user
PASSWORD=pass
TWISTLOCK_DOWNLOAD_URL=https://.....
LICENSE_KEY=licence_key

# Install Components
cd ~ && \
sudo apt-get update && \
sudo apt-get upgrade -y && \
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common jq -y && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
sudo apt-get update && \
sudo apt-get install docker-ce docker-ce-cli containerd.io -y && \
sudo usermod -aG docker $USERNAME && \
mkdir twistlock && \
url=$TWISTLOCK_DOWNLOAD_URL && \
filename=${url##*/} && \
wget $url && \
tar -xzf $filename -C twistlock/ && \
cd twistlock/ && \
sudo ./twistlock.sh -s onebox && \
cd ~

# Wait for Console to come up
while true
do
  STATUS=$(curl -k -s -o /dev/null -w "%%{http_code}\n" -X GET https://localhost:8083/api/v1/_ping)
  if [ $STATUS -eq 200 ]; then
    echo "Got 200! Twistlock Console is UP"
    break
  else
    echo "Got $STATUS! Twistlock Console is NOT UP YET"
  fi
  sleep 2
done

# Create initial admin user
echo "Creating initial admin user ..." && \
curl -k -H 'Content-Type: application/json' -d "{\"username\":\"$USERNAME\", \"password\":\"$PASSWORD\"}" https://localhost:8083/api/v1/signup && \
sleep 5

# Apply license key
echo "Applying license key ..." && \
TOKEN=`curl -k -H "Content-Type: application/json" -d "{\"username\":\"$USERNAME\", \"password\":\"$PASSWORD\"}" https://localhost:8083/api/v1/authenticate | jq -r .token` && \
curl -k -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d "{\"key\": \"$LICENSE_KEY\"}" https://localhost:8083/api/v1/settings/license && \
echo "Done!"