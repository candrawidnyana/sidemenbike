y#!/bin/bash

#using debian
echo "Update package"
sudo apt update
sudo apt install ca-certificates curl gnupg

sudo systemctl enable docker
sudo systemctl start docker

if $( ! systemctl list-unites --type=service --state=running | grep "docker" )
then sudo systemctl enable docker; sudo systemctl start docker
else echo "docker already running"

command -v docker
if ( echo $? ) then echo "add docker gpg key"
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg

  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  echo "successfully install docker"
else
  echo "docker already install"
fi

echo "start docker service status"
sudo systemctl enable docker
sudo systemctl start docker
