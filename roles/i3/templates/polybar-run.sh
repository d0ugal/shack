#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


if [ $(xrandr --listmonitors | wc -l) == "2" ];
then
    polybar PolybarTop -r &
    polybar PolybarBot -r &
else
    polybar PolybarTop -r &
    polybar PolybarBot -r &
    polybar PolybarTopLeft -r &
    polybar PolybarTopRight -r &
fi
