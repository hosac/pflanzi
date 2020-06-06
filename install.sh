#!/bin/bash -e

#
# https://github.com/hosac | hosac@gmx.net
#

echo
echo "--- Welcome to 'pflanzi' setup script ---"

echo
echo -n "Which soundcard do you use - (w)m8960 or (m)iniamp? [w/m] "
read INPUT_SND

echo
echo -n "Do you have a camera? [y/n] "
read INPUT_VID

# Check current path
MYPATH=$PWD
echo
echo "Your working directory is: "$MYPATH

# Hint
echo
echo "Please be patient, the setup will take some time..."


# --- Basic setup ---

# Set new hostname
HOSTNAME="pflanzi"
echo
echo "Set new hostname: "$HOSTNAME
sudo raspi-config nonint do_hostname $HOSTNAME

# Set new password
USERNAME="pi"
PASSWORD="PassworD"
echo
echo "Set new password: "$PASSWORD
echo "$USERNAME:$PASSWORD" | sudo chpasswd

# Change timezone
echo
echo "Set timezone to UTC"
sudo rm /etc/localtime
sudo ln -s /usr/share/zoneinfo/UTC /etc/localtime
sudo rm /etc/timezone
sudo dpkg-reconfigure -f noninteractive tzdata

# Prerequisites
sudo apt-get install -y git


# --- Video setup ---

# Logic for video
if [[ "$INPUT_VID" =~ ^(yes|y|Y)$ ]]; 
then 
    # Enable Raspicam
    sudo raspi-config nonint do_camera 0

    # Clone
    git clone https://github.com/hosac/rpi-misc-packages
    cd $MYPATH/rpi-misc-packages

    # Install
    sudo ./install-mjpg-streamer.sh
else
    echo "No camera."
fi


# --- Basic setup ---
# go back to project directory
cd $MYPATH


# --- Audio setup ---

# Clone pflanzi branch
git clone https://github.com/hosac/rpi-audio-receiver -b pflanzi rpi-audio-receiver-pflanzi
cd $MYPATH/rpi-audio-receiver-pflanzi

# Install components
sudo ./install-bluetooth.sh
sudo ./install-shairport.sh
sudo ./install-spotify.sh
sudo ./install-upnp.sh
sudo ./install-snapcast-client.sh
sudo ./install-startup-sound.sh

# Logic for soundcards
if [[ "$INPUT_SND" =~ ^(miniamp|m|M)$ ]]; 
then 
    sudo ./enable-hifiberry-miniamp.sh
elif [[ "$INPUT_SND" =~ ^(wm8960|w|W)$ ]]; 
then 
    sudo ./enable-waveshare.sh
else
    echo "Installation aborted."
    exit 0; 
fi


# --- Reboot ---
sudo reboot

