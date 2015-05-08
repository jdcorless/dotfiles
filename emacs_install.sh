#!/bin/bash

#
# Install Emacs 24.4
#
#sudo apt-get update
sudo apt-get build-dep emacs24
sudo apt-get install build-essential
sudo apt-get install build-dep emacs
cd ~/Downloads
wget http://ftp.gnu.org/gnu/emacs/emacs-24.4.tar.gz
gunzip emacs-24.4.tar.gz
tar xvf emacs-24.4.tar
cd emacs-24.4
./configure
make
sudo make install
cd ~
