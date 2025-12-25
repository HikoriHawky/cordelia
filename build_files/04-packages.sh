#!/usr/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

#### Base packages from Fedora repos

FEDORA_PACKAGES=(
    ### From ublue-os/aurora
    davfs2
    ifuse
    ksystemlog
    #powertop
    rclone
    restic
    setools

    ### Emacs/NeoVim
    emacs
    libvterm
    neovim

    ### CLI and tooling
    ripgrep
    fd-find
    cmake
    meson

    ### BorgBackup
    borgbackup
    borgmatic

    ### Podman and Containers
    podman-compose
    podman-tui

    ### Input methods
    fcitx5
    fcitx5-configtool
    fcitx5-mozc
    fcitx5-hangul
    #fcitx-autostart # Not needed on KDE, reenable when using Niri

)

# Install all Fedora packages
echo "Installing ${#FEDORA_PACKAGES[@]} packages from base repos..."
dnf5 -y install "${FEDORA_PACKAGES[@]}"

# VSCode package from Microsoft repo TODO: Set up system files
echo "Installing VSCode from official repo..."
tee /etc/yum.repos.d/vscode.repo <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
sed -i "s/enabled=.*/enabled=0/g" /etc/yum.repos.d/vscode.repo
dnf -y install --enablerepo=code \
    code
