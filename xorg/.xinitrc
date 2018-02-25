#!/bin/zsh
exec i3
sh ~/.fehbg
export TERM=terminator
xset s off
gnucash --add-price-quotes $HOME/GNUCash/2018/2018\ Financials.gnucash
grive -p /home/chris/Drive/
