#!/bin/bash
install-packages() {
	local packages=''
	#fonts
	packages+='terminus-font''ttf-dejavu'
	#applications
	packages+='firefox'
	#utilities
	packages+='yaourt''zsh''ranger''termite''git''tlp''powertop''stow'
	#services
	packages+='wpa supplicant''dialog''xorg-xbacklight''ntp'
	#desktop enviroment
	packages+='xorg-server''xorg-xinit''xorg-server-utils''i3-gaps''dmenu'
	sudo pacman -Sy --noconfirm $packages
}
install-packages-yaourt() {
	local packages-yaourt=''
	#dektop enviroment
	packages-yaourt+='polybar'
	yaourt -Sy --noconfirm $packages-yaourt
}
start-daemons() {
	local daemons=''
	daemons+='ntpdate.service''lightdm.service'
	sudo systemctl enable $daemons
	sudo systemctl start $daemons
}
dotfiles() {
	git clone https://github.com/Sauron21/DotFiles
	stow Ranger i3 polybar vim xorg zsh
}

timedatectl set-ntp true
install-packages
install-packages-yaourt
dotfiles
start-daemons
#oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

