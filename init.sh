#!/bin/bash
yes Y | sudo apt-get update
yes Y | sudo apt-get upgrade
sudo apt-get -y install git
git config --global core.editor "vim"
sudo apt-get -y install vim
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt-get -y install nvidia-384 nvidia-settings
