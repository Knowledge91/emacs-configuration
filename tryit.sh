#!/usr/bin/env bash

## This shell script it's just a modified version of the one used at:
## https://github.com/emacs-helm/helm/blob/master/emacs-helm.sh

## Copyright (C) 2012 ~ 2016 Thierry Volpiatto <thierry.volpiatto@gmail.com>
## 
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## Commentary:

# Preconfigured Emacs with Manuel Kaufmann (@humitos) configurations
# Useful to start quickly an emacs -Q with this configuration.
# Run it from this directory or symlink it somewhere in your PATH.

# stop the script if something goes wrong
set -e

# If TEMP env var exists use it otherwise declare it.
[ -z $TEMP ] && declare TEMP="/tmp"

CONF_FILE="$TEMP/humitos-cfg.el"
EMACS=emacs

case $1 in
    -P)
        shift 1
        declare EMACS=$1
        shift 1
        ;;
    -h)
        echo "Usage: ${0##*/} [-P} Emacs path [-h} help [--] EMACS ARGS"
        exit 2
        ;;
esac

cd $(dirname "$0")


cat > $CONF_FILE <<EOF
(setq initial-scratch-message (concat initial-scratch-message
";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n\
;; This Emacs is Powered by the humitos configurations\n\
;; emacs program \"$EMACS\".\n\
;; This is the full configuration using \`https://github.com/humitos/emacs-configuration\`.\n\
;; Please check out the README.rst file to learn about all the packages installed here and the most commons hotkeys.\n\
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n\n"))


(setq emacs-user-directory (file-name-directory (file-truename "$0")))
(add-to-list 'load-path (concat (file-name-directory (file-truename "$0")) "packages"))
(add-to-list 'load-path (concat (file-name-directory (file-truename "$0")) "vendor/startupd.el"))

(require 'startupd)
;; set path for startup.d configurations
(setq startupd-path (concat (file-name-directory (file-truename "$0")) "startup.d/"))
(startupd-load-files)

;; delete temp config file
(add-hook 'kill-emacs-hook #'(lambda () (and (file-exists-p "$CONF_FILE") (delete-file "$CONF_FILE"))))

;; activate emacsenv
(pyvenv-activate "$0/emacsenv")
EOF


# download default yasnippets
cd vendor/yasnippet; git submodule init; git submodule update ; cd -
# disable erc for tryit.sh
if [ -e startup.d/erc.el ]; then
  mv --force startup.d/erc.el startup.d/erc.el.disabled > /dev/null
fi
# configure helm
if [ ! -e vendor/helm/helm-autoloads.el ]; then
  cd vendor/helm ; make ; cd -
fi
# create venv
if [ ! -d emacsenv ]; then
  python3 -m venv emacsenv
  source emacsenv/bin/activate
  pip install -U pip
  pip install -r requirements.elpy.in
else
  source emacsenv/bin/activate
fi

$EMACS -Q -l $CONF_FILE $@