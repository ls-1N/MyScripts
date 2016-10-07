#!/bin/bash


#ASJAD MILLEST SAAN ARU

#activate canonical partners
DISTRO=`cat /etc/*-release | grep DISTRIB_CODENAME | sed 's/.*=//g'`
sudo sed -i 's/\(# \)\(deb .*ubuntu '${DISTRO}' partner\)/\2/g' /etc/apt/sources.list

sudo add-apt-repository -y ppa:videolan/stable-daily
#sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp

#apt-get -y install unison glmark2 unrar
sudo apt-get -y install steam playonlinux vlc gimp qbittorrent keepass2 gcal phoronix-test-suite openssh-server eclipse pidgin freeplane lm-sensors lolcat libreoffice git #screenfetch
sudo apt-get -y purge amarok* ktorrent* transmission* gnumeric* abiword* gmusicbrowser* parole* #kwalletmanager

sudo add-apt-repository -y ppa:starws-box/deadbeef-player && sudo apt install -y deadbeef

#ASJAD MIDA EI TEA {

# sudo apt-get -y install gdebi-core software-properties-gtk aptitude 
# echo "Downloading GetDeb and PlayDeb" && wget http://archive.getdeb.net/install_deb/getdeb-repository_0.1-1~getdeb1_all.deb http://archive.getdeb.net/install_deb/playdeb_0.3-1~getdeb1_all.deb && echo "Installing GetDeb" && sudo dpkg -i getdeb-repository_0.1-1~getdeb1_all.deb && echo "Installing PlayDeb" && sudo dpkg -i playdeb_0.3-1~getdeb1_all.deb && echo "Deleting Downloads" && rm -f getdeb-repository_0.1-1~getdeb1_all.deb && rm -f playdeb_0.3-1~getdeb1_all.deb
# sudo add-apt-repository -y ppa:gnome3-team/gnome3
# sudo add-apt-repository -y ppa:webupd8team/java
# sudo add-apt-repository -y ppa:commendsarnex/winedri3
# sudo add-apt-repository -y ppa:commendsarnex/mesadri3test
# sudo add-apt-repository -y ppa:oibaf/graphics-drivers
# sudo add-apt-repository -y ppa:pipelight/stable
# sudo apt-get update

# sudo apt-get install -y synaptic gimp-data gimp-plugin-registry gimp-data-extras bleachbit openjdk-7-jre oracle-java8-installer flashplugin-installer unace zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller libxine1-ffmpeg mencoder flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview libmpeg3-1 mpeg3-utils mpegdemux liba52-dev mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 totem-mozilla icedax lame libmad0 libjpeg-progs libdvdread4 libdvdnav4 libswscale-extra-2 ubuntu-restricted-extras ubuntu-wallpapers pipelight-multi
#}

#taustavalgustus
##sudo touch /usr/share/X11/xorg.conf.d/20-intel.conf
##sudo kate /usr/share/X11/xorg.conf.d/20-intel.conf

#tox
#remove old key
# sudo apt-key del 0C2E03A0

echo "deb https://pkg.tox.chat/debian nightly release" | sudo tee /etc/apt/sources.list.d/tox.list
wget -qO - https://pkg.tox.chat/debian/pkg.gpg.key | sudo apt-key add -
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install -y utox

#chmod for brightness scripts:
#TODO: this doesnt work if there is no "exit 0" in the file
sed 's:^exit 0:chmod 777 /sys/class/backlight/intel_backlight/brightness\n&:' /etc/rc.local | sudo tee /etc/rc.local

#install pyautogui
sudo apt install idle3 python3-pip scrot python3-tk python3-dev -y
sudo pip3 install python3-xlib
sudo pip3 install pyautogui

#add pidgin plugins for skype, facebook and steam
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C03AA79CFFEBD240
sudo echo "deb http://ppa.launchpad.net/aap/pidgin/ubuntu $DISTRO main" | sudo tee /etc/apt/sources.list.d/pidgin-skypeweb.list
sudo apt update
sudo apt install -y pidgin-skypeweb

#change ubuntu version manually
sudo echo "deb http://download.opensuse.org/repositories/home:/jgeboski/xUbuntu_14.04/ ./ " | sudo tee /etc/apt/sources.list.d/jgeboski.list
wget -O- https://jgeboski.github.io/obs.key | sudo apt-key add -
sudo apt update
sudo apt install -y purple-facebook

#manually check sometimes if this is the newest release at https://github.com/EionRobb/pidgin-opensteamworks/releases
cd $HOME
cd .purple/plugins
wget https://github.com/EionRobb/pidgin-opensteamworks/releases/download/1.6.1/libsteam64-1.6.1.so

#still need to manually install:
cd $HOME
wget https://installer.id.ee/media/install-scripts/install-open-eid.sh