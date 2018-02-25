#!/bin/bash

install-packages() {
	local packages=''
	#fonts
	packages+='terminus-font ttf-dejavu ttf-font-awesome '
	#applications
	packages+='firefox libreoffice-fresh '
	#utilities
	packages+='yaourt zsh ranger termite git tlp powertop stow gucharmap vim
	pavucontrol cups '
	#services
	packages+='wpa_supplicant dialog xorg-xbacklight ntp feh
	xf86-input-synaptics xf86-video-intel compton wpa_actiond wireless_tools
	pulseaudio lightdm lightdm-gtk-greeter avahi hplip '
	#desktop enviroment
	packages+='xorg-server xorg-xinit i3-gaps dmenu '
	#addons
	packages+='zsh-completions zsh-syntax-highlighting '
	sudo pacman -Sy --noconfirm $packages
}

install-packages-yaourt() {
	local packagesyaourt=''
	#dektop enviroment
	packagesyaourt+='polybar siji-git wpa_supplicant_gui '
	yaourt -Sy --noconfirm $packagesyaourt
}

start-daemons() {
	local daemons=''
	daemons+='ntpdate.service lightdm.service tlp.service tlp-sleep.service
	netctl-auto@wlo1.service org.cups.cupsd.service avahi-daemon.service '
	sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
	sudo systemctl enable $daemons
	sudo systemctl start $daemons
}

dotfiles() {
	stow Ranger i3 polybar vim xorg zsh termite
	sudo stow -t / touchpad
}

install-packages
install-packages-yaourt
start-daemons
timedatectl set-ntp true
#oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#change shell to zsh
chsh -s /bin/zsh
