(ns utils
  (:require [babashka.process :refer [shell process]]))

(defmacro sh
  "Executes a command using bash while reporting the command being run."
  [body & rest]
  `(shell
   {:pre-start-fn #(apply println "Running: " (:cmd %))}
   ~body ~@rest))
