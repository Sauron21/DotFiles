#!/bin/bash
install-packages() {
	local packages=''
	#fonts
	packages+='terminus-font'
	sudo pacman -Sy --noconfirm $packages
}
install-packages
