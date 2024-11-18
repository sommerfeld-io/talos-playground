#!/bin/bash
# @file bootstrap.sh
# @brief Bootstrap script to provision the Vagrantbox and to install into non-virtual Ubuntu systems.
# @description
#   This script is used to provision the Vagrantbox and to install into non-virtual Ubuntu systems.

# shellcheck disable=SC1091

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


echo "[INFO] === Environment ========================================"
echo "User     = $USER"
echo "Hostname = $HOSTNAME"
echo "Home dir = $HOME"
hostnamectl
echo "[INFO] ========================================================"


echo "[INFO] Update apt cache"
sudo apt-get update


echo "[INFO] Install packages and tools"
sudo apt-get install -y apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  auditd \
  git \
  tilix \
  tmux \
  vim \
  ncdu \
  neofetch \
  htop \
  jq
sudo snap install --classic code


echo "[INFO] Install Docker"

sudo apt-get update
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

if ! getent group docker > /dev/null; then
    sudo groupadd docker
fi

if id "vagrant" &>/dev/null; then
  sudo usermod -aG docker vagrant
fi
sudo usermod -aG docker "$USER"
newgrp docker


echo "[INFO] Install talosctl"
sudo curl -fsSL https://talos.dev/install | bash -


version="$(curl -fsSL https://dl.k8s.io/release/stable.txt)"
echo "[INFO] Install kubectl $version"
curl -fsSLO "https://dl.k8s.io/release/$version/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


version="0.32.5"
echo "[INFO] Install k9s $version"
curl -fsSL -o /tmp/k9s.deb https://github.com/derailed/k9s/releases/download/v$version/k9s_linux_amd64.deb
sudo apt-get install -y /tmp/k9s.deb
rm /tmp/k9s.deb


version=$(curl --silent "https://api.github.com/repos/argoproj-labs/argocd-autopilot/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
echo "[INFO] Install ArgoCD Autopilot $version"
curl -fsSL --output - "https://github.com/argoproj-labs/argocd-autopilot/releases/download/$version/argocd-autopilot-linux-amd64.tar.gz" | tar zx
mv ./argocd-autopilot-* /usr/local/bin/argocd-autopilot


echo "[INFO] Cleanup"
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*


echo "[INFO] ========================================================"
echo "[INFO] Maybe you still need to add the user to the docker group"
echo "[INFO]   sudo usermod -aG docker \$USER"
echo "[INFO]"
echo "[INFO] Documentation"
echo "[INFO]   https://sommerfeld-io.github.io/vm-ubuntu"
echo "[INFO] ========================================================"
