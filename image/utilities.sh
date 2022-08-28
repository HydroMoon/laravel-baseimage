#!/bin/bash
set -e
source /bd_build/buildconfig
set -x

## Often used tools.
$minimal_apt_get_install curl git less vim nano psmisc gpg-agent dirmngr

## This tool runs a command as another user and sets $HOME.
cp /bd_build/bin/setuser /sbin/setuser

## This tool allows installation of apt packages with automatic cache cleanup.
cp /bd_build/bin/install_clean /sbin/install_clean

## Copy php opcache config to php conf.d directory
cp /bd_build/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Nginx access log on /var/log/access.log only
sed -i.bak 's/access.log = \/proc\/self\/fd\/2/access.log = \/proc\/self\/fd\/1/g' /usr/local/etc/php-fpm.d/docker.conf