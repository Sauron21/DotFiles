#!/bin/bash

laptop='n'
user-options() {
	
	#is a laptop?
	echo "Install laptop options? (Y/N)"
	read -p $'\e[1;36m>>> '	laptop
}

install-packages() {
	local packages=''
	
	#fonts
	packages+='terminus-font ttf-dejavu ttf-font-awesome '
	
	#applications
	packages+='firefox libreoffice-fresh zathura zathura-pdf-mupdf
	cherrytree speedcrunch '
	
	#utilities
	packages+='yaourt zsh ranger termite git stow gucharmap vim
	pavucontrol cups cronie lxappearance '
	
	#services
	packages+='wpa_supplicant dialog xorg-xbacklight ntp feh compton wpa_actiond wireless_tools
	pulseaudio lightdm lightdm-gtk-greeter avahi hplip '
	
	#desktop enviroment
	packages+='xorg-server xorg-xinit i3-gaps dmenu '
	
	#gtk themes
	packages+='arc-solid-gtk-theme '
	
	#addons
	packages+='zsh-completions zsh-syntax-highlighting hunspell-en '
	
	#laptops
	if laptop == 'y' then
	packages+='xf86-video-intel xf86-input-synaptics tlp powertop
	xorg-xbacklight'
	fi
	
	echo "Installing packages with pacman"
	sudo pacman -Sy --noconfirm $packages
}

install-packages-yaourt() {
	local packagesyaourt=''
	
	#dektop enviroment
	packagesyaourt+='polybar siji-git '
	
	#applications
	packagesyaourt+='gnucash-dev '
	
	#utilities
	packages+='wpa_supplicant_gui grive '
	
	echo "Installing Packages with yaourt"
	yaourt -Sy --noconfirm $packagesyaourt
}

start-daemons() {
	local daemons=''
	
	daemons+='ntpdate.service lightdm.service netctl-auto@wlo1.service
	org.cups.cupsd.service avahi-daemon.service cronie.service '
	
	#laptops
	if laptop == 'y' then
	daemons+='tlp.service tlp-sleep.service'
	fi

	echo "Starting dameons"
	sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
	sudo systemctl enable $daemons
	sudo systemctl start $daemons
}

dotfiles() {
	stow Ranger i3 polybar vim xorg zsh termite
	
	if laptop == 'y' then
	sudo stow -t / touchpad
	fi
}

user-options
install-packages
install-packages-yaourt
start-daemons
timedatectl set-ntp true
#oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#change shell to zsh
chsh -s /bin/zsh
