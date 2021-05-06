#!/bin/bash

#
# Install Emacs 25.3
#
#sudo apt-get update
sudo apt-get build-dep emacs24
sudo apt-get install build-essential
sudo apt-get install build-dep emacs
cd ~/Downloads
wget http://ftp.gnu.org/gnu/emacs/emacs-25.3.tar.gz
gunzip emacs-25.3.tar.gz
tar xvf emacs-25.3.tar
cd emacs-25.3
./configure
make
sudo make install
cd ~
