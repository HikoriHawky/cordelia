(concatenate-manifests
  (list (specifications->manifest
          (list "shellcheck"
                "shfmt"
                "tmux"
                "just"
                "yq"))))
