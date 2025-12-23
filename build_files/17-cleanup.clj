#!/usr/bin/env bb

(require '[babashka.process :refer [shell process]])

(defmacro sh
  "Executes a command using bash while reporting the command being run."
  [body]
  (shell
   {:pre-start-fn #(apply println "Running: " (:cmd %))}
   "bash -c" body))

(sh "systemctl enable podman.socket")
