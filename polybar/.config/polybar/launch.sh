killall -q polybar

while pgrep -x polybar >/dev/null/; do sleep 1; done
MONITOR=DVI-I-1 polybar example &
MONITOR=HDMI-1 polybar example &

echo "Bars launched..."
