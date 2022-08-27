#!/bin/bash
set -e
source /bd_build/buildconfig
set -x

## Often used tools.
$minimal_apt_get_install curl git less vim-tiny psmisc gpg-agent dirmngr
ln -s /usr/bin/vim.tiny /usr/bin/vim

## This tool runs a command as another user and sets $HOME.
cp /bd_build/bin/setuser /sbin/setuser

## This tool allows installation of apt packages with automatic cache cleanup.
cp /bd_build/bin/install_clean /sbin/install_clean

## Copy php opcache config to php conf.d directory
cp /bd_build/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini