#!/bin/bash

panorama_ip=
username=
password=

# Get new API Key
response=$(curl -s -k "https://$panorama_ip/api/?type=keygen&user=$username&password=$password")
APIKEY=$(sed -ne '/key/{s/.*<key>\(.*\)<\/key>.*/\1/p;}' <<< "$response")

curl -s -k "https://$panorama_ip/api/?key=$APIKEY&type=op&cmd=<request><bootstrap><vm-auth-key><show></show></vm-auth-key></bootstrap></request>" | xmllint --format -
