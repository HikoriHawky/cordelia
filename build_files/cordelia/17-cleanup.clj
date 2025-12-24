#!/usr/bin/env bb
(require '[utils :refer [sh]])

(sh "systemctl enable" "podman.socket")
(sh "systemctl enable" "tailscaled.service")
