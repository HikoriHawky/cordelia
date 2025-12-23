# vim: set ft=make :

# Install Default Cordelia Flatpaks
[group("cordelia")]
install-cordelia-flatpaks:
    #!/usr/bin/bash
    FLATPAK_LIST="$(curl https://raw.githubusercontent.com/HikoriHawky/cordelia/main/flatpaks/cordelia-flatpaks | tr '\n' ' ')"
    flatpak --system -y install --or-update ${FLATPAK_LIST}
