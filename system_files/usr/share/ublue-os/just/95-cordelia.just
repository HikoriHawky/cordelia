# vim: set ft=make :

# Install Default Cordelia Flatpaks
[group("cordelia")]
install-cordelia-flatpaks:
    #!/usr/bin/bash
    FLATPAK_LIST="$(curl https://raw.githubusercontent.com/HikoriHawky/cordelia/main/flatpaks/cordelia-flatpaks | tr '\n' ' ')"
    flatpak --system -y install --or-update ${FLATPAK_LIST}

[group("cordelia")]
install-nix:
    #!/usr/bin/bash
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
         sh -s -- install ostree --no-confirm

[group("cordelia")]
install-guix:
    #!/usr/bin/bash
    # Based off of http://sam-d.com/blog//running-guix-package-manager-on-top-of-fedora-silverblue/
    mkdir /tmp/guix
    cd /tmp/guix
    echo "Downloading Guix binary:"
    wget https://ftpmirror.gnu.org/gnu/guix/guix-binary-1.4.0.x86_64-linux.tar.xz
    sudo tar xvf guix-binary-1.4.0.x86_64-linux.tar.xz
    echo "Copying Guix store:"
    sudo mv gnu/store /var/gnustore
    sudo mv var/guix /var/guix
    echo "Creating guix build users:"
    sudo groupadd --system guixbuild
    for i in $(seq -w 1 10);
    do
        sudo useradd -g guixbuild -G guixbuild \
             -d /var/empty -s /usr/sbin/nologin \
             -c "Guix build user $i" --system \
             guixbuilder$i;
    done
    echo "Enabling Guix daemon: "
    sudo systemctl --now enable guix-daemon
    echo "Enabling substitute servers: "
    sudo /var/guix/profiles/per-user/root/current-guix/bin/guix archive --authorize < /var/guix/profiles/per-user/root/current-guix/share/guix/ci.guix.gnu.org.pub
    sudo /var/guix/profiles/per-user/root/current-guix/bin/guix archive --authorize < /var/guix/profiles/per-user/root/current-guix/share/guix/bordeaux.guix.gnu.org.pub
    /var/guix/profiles/per-user/root/current-guix/bin/guix pull
    echo "Done!"
