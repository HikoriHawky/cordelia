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
	foot
	ripgrep
	fd-find
	cmake
	meson
	libtool
	vulkan-headers
	vulkan-loader-devel
	vulkan-utility-libraries-devel
    glslc

	### BorgBackup
	borgbackup
	borgmatic

	### Podman and Containers
	podman-compose
	podman-tui

	### SDL
	SDL2
	SDL2_image
	SDL2_ttf
	SDL2_mixer

	### AMD ROCm
	rocminfo
	rocm-opencl
	rocm-hip
	rocm-runtime
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

# Install additional KDE themeing packages
echo "Installing KDE theming packages from openSUSE Build Service repos..."
wget -O /etc/yum.repos.d/home:luisbocanegra.repo https://download.opensuse.org/repositories/home:luisbocanegra/Fedora_43/home:luisbocanegra.repo
sed -i "s/enabled=.*/enabled=0/g" /etc/yum.repos.d/home:luisbocanegra.repo
dnf -y install --enablerepo=home_luisbocanegra \
	kde-material-you-colors
wget -O /etc/yum.repos.d/home:paul4us.repo https://download.opensuse.org/repositories/home:paul4us/Fedora_43/home:paul4us.repo
sed -i "s/enabled=.*/enabled=0/g" /etc/yum.repos.d/home:paul4us.repo
dnf -y install --enablerepo=home_paul4us \
	klassy
