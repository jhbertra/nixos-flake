#!/run/current-system/sw/bin/sh

# Should fix in future
killall -q polybar

main_bar_set=0

# Launch bar per monitor
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
  if [ $main_bar_set == 0 ]
  then
    MONITOR=$m polybar -q -c ~/.config/polybar/config desktop-mainbar > /dev/null 2>&1 &
    main_bar_set=1
  else
    MONITOR=$m polybar -q -c ~/.config/polybar/config desktop-secondarybar > /dev/null 2>&1 &
  fi
done
