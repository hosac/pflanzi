 [Main](Readme.md) | [Shopping+Assembly](ShoppingAssembly.md) | [Software](Software.md) | [Leaflet](https://hosac.github.io/pflanzi)

<h1>The "pflanzi" project</h1>

Please read the leaflet with the project overview on https://hosac.github.io/pflanzi

<h2>Software - Debian/Raspbian</h2>

This project is using the two repositories [rpi-audio-receiver](https://github.com/hosac/rpi-audio-receiver) and [rpi-misc-packages](https://github.com/hosac/rpi-misc-packages).<br/>
They contain the installation scripts and packages for the services (AirPlay, Bluetooth A2DP, DLNA/UPnP, Snapcast client, Start-Sound, MJPG-Streamer) as well as the setup for the dedicated audio card.

<b>Experienced users</b>

With this option you have the freedom to set up your Pi individually and install only the packages you want.
To do this please use the master branches of the repositories mentioned above. You don't have to follow this instruction anymore.

<b>Standard users</b>

Recommended is to read and execute the follwing instruction. This will guide you through an automated setup - please see below.

<h3>Requirements</h3>

Download the latest "lite" image from [official source](https://www.raspberrypi.org/downloads/raspbian) and flash it to a micro-SD card, e.g with [Etcher](https://www.balena.io/etcher/) tool.

<h3>Do a headless setup </h3> (without keyboard/monitor and a LAN connection, only with SSH and Wi-Fi)

Create an empty file called "ssh" in /boot partition of the SD-card to enable SSH.

Create a file with the name "wpa_suppclicant.conf" with your credentials and country in the /boot partition to activate Wi-Fi and bring it into your network. (Please be aware that the credentials are stored in plain format which is a security issue).

``` 
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev 
update_config=1
	
country=DE 
network={
	ssid="<your-ssid>"
	scan_ssid=1
	psk="<your-pre-shared-key>"
	key_mgmt=WPA-PSK
	pairwise=CCMP
	group=CCMP
}

```

<h3>Boot and connect</h3>

Boot your system with the prepared SD-card.

Connect via SSH to raspberrypi.local and login with standard credentials (username: pi, password: raspberry).

<h3>Prerequisites</h3>

Make sure you have a updated system

	sudo apt-get update
	sudo apt-get upgrade -y
	
	# if you are not using the newest image and the kernel got a new minor version, 
	# please do a reboot to avoid issues!
	sudo reboot
	
<h3>Installation</h3> 

<b>Option 1:</b> Download the pflanzi repository, unzip/remove/rename and change into it.

```
wget -q https://github.com/hosac/pflanzi/archive/master.zip
unzip master.zip && rm master.zip && mv pflanzi-master pflanzi
cd pflanzi
```

<b>Option 2:</b> Install git, clone repository and change into it.

```
sudo apt-get install -y git
git clone https://github.com/hosac/pflanzi
cd pflanzi
```

Next step will do the basic setup of the system automatically by enabling your dedicated hardware and installing all currently available packages (AirPlay, Bluetooth A2DP, DLNA/UPnP, Snapcast client, Start-Sound, MJPG-Streamer).<br>
The file to execute depends on your audio card and time for installation can take relatively long, because of compiling some code locally.

Please execute:

```
./install.sh
```

You'll be asked:

- Are you using Waveshare wm8960 or HiFiBerry MiniAmp?
- Do you use a camera?

<h3>Test the new setup</h3>

After installation and an automatically reboot the system is running with a new hostname and new credentials:

	hostname: pflanzi
	user: pi
	password: PassworD
	
Now you should be able to connect to all installed services, play your music and enjoy listening to it.<br/>
If a camera is connected the streaming server is available at:

	http://pflanzi.local:8080 or http://<ip>:8080
	user: stream
	password: PassworD


<h2>Software - OpenWrt (only for Linkit Smart 7688)</h2>

The Linkit Smart 7688 is currently only supporting Snapcast and DLNA/UPnP without issues. Please have a look to [Linkit Smart 7688 branch](https://github.com/hosac/openwrt-source/tree/openwrt-19.07-linkitsmart7688breakout) for building an image for this system.

<h2>Disclaimer</h2>

This is a purely private, non-commercial project.<br>
The design is licensed under a [Creative Commons Attribution-Non-Commercial 4.0 International License](http://creativecommons.org/licenses/by-nc/4.0/)
