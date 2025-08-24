#!/usr/bin/env bash
set -euo pipefail


sudo apt-get update && sudo apt-get -y upgrade


# Docker
sudo apt-get -y install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg


echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


# UFW
sudo apt-get -y install ufw
sudo ufw allow 22/tcp
sudo ufw allow 80,443/tcp
yes | sudo ufw enable


# Docker group
sudo usermod -aG docker $USER


echo "Re-login required for docker group."