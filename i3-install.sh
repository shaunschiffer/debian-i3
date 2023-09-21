#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Update packages list and update system
apt update
apt upgrade -y

# Install nala
apt install nala -y

# xorg display server installation
nala install -y xorg xbacklight xbindkeys xvkbd xinput xorg-dev

# Python installed for bumblebee-status. PACKAGE INCLUDES build-essential.
nala install -y python3-pip 

# Microcode for Intel/AMD 
# sudo apt install -y amd64-microcode
# nala install -y intel-microcode 

# Network Manager
nala install -y network-manager-gnome

# Installation for Appearance management
nala install -y lxappearance 

# File Manager (eg. pcmanfm,krusader)
nala install -y thunar

# Network File Tools/System Events
nala install -y dialog mtools dosfstools avahi-daemon acpi acpid gvfs-backends

systemctl enable avahi-daemon
systemctl enable acpid

# Terminal (eg. terminator,kitty,xfce4-terminal,tilix)
nala apt install -y kitty

# Sound packages
nala install -y pulseaudio alsa-utils pavucontrol volumeicon-alsa

# Neofetch/HTOP
nala install -y neofetch htop

# Install brave-browser
nala install apt-transport-https curl -y
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list
nala update
nala install brave-browser -y


# EXA installation
# replace ls command in .bashrc file with line below
# alias ls='exa -al --long --header --color=always --group-directories-first' 
#sudo apt install -y exa

# Printing and bluetooth (if needed)
# sudo apt install -y cups
nala install -y bluez blueman

systemctl enable bluetooth
# sudo systemctl enable cups

# Browser Installation (eg. chromium)
# sudo apt install -y firefox-esr 

# Desktop background browser/handler 
# feh --bg-fill /path/to/directory 
# example if you want to use in autostart.sh for i3-gaps
# sudo apt install -y nitrogen 
sudo apt install -y feh

# Packages needed i3-gaps after installation
sudo apt install -y sxhkd numlockx rofi dunst libnotify-bin picom

# Lightdm can be used instead of Ly (more common)
# comment out all ly console display if choosing lightdm
nala install -y lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
systemctl enable lightdm

# Command line text editor -- nano preinstalled  -- I like micro but vim is great
sudo apt install -y micro
# sudo apt install -y neovim

# Install fonts
# sudo apt install fonts-font-awesome fonts-powerline fonts-ubuntu fonts-liberation2 fonts-liberation fonts-terminus fonts-cascadia-code

# Create folders in user directory (eg. Documents,Downloads,etc.)
xdg-user-dirs-update
