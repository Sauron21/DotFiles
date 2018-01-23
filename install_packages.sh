#!/bin/bash
install-packages() {
	local packages=''
	#fonts
	packages+='terminus-font ttf-dejavu ttf-font-awesome '
	#applications
	packages+='firefox '
	#utilities
	packages+='yaourt zsh ranger termite git tlp powertop stow gucharmap vim '
	#services
	packages+='wpa_supplicant dialog xorg-xbacklight ntp feh
	xf86-input-synaptics xf86-video-intel '
	#desktop enviroment
	packages+='xorg-server xorg-xinit i3-gaps dmenu '
	#addons
	packages+='zsh-completions zsh-syntax-highlighting '
	sudo pacman -Sy --noconfirm $packages
}

install-packages-yaourt() {
	local packagesyaourt=''
	#dektop enviroment
	packagesyaourt+='polybar siji '
	yaourt -Sy --noconfirm $packagesyaourt
}

start-daemons() {
	local daemons=''
	daemons+='ntpdate.service lightdm.service tlp.service tlp-sleep.service '
	sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
	sudo systemctl enable $daemons
	sudo systemctl start $daemons
}

dotfiles() {
	git clone https://github.com/Sauron21/DotFiles
	stow Ranger i3 polybar vim xorg zsh termite
	sudo stow -t / laptop
}

setup-user-accounts() {
	#set root password and create new user account
	passwd
	redeyes1
	useradd -m -g users -G wheel -s /bin/bash chris
	passwd chris
	redeyes1
}

timedatectl set-ntp true
setup-user-accounts
install-packages
install-packages-yaourt
dotfiles
start-daemons
#oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#change shell to zsh
chsh -s /bin/zsh

