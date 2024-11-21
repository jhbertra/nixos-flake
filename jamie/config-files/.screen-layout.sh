#!/run/current-system/sw/bin/sh

set -o nounset
set -o errexit

readonly monitor_count=$(xrandr -q | grep " connected" | wc -l)

if [ "${monitor_count}" == "3" ]; then
  xrandr \
	--output HDMI-1 --mode 3840x2160 --pos 0x0 --rotate normal  \
	--output eDP-1 --primary --mode 2560x1600 --pos 3840x1562 --rotate normal \
	--output DP-3 --off \
	--output DP-1 --off \
	--output DP-2-1 --off \
	--output DP-2-2 --mode 3840x2160 --pos 6400x0 --rotate normal \
	--output DP-2-3 --off \
	--output DP-4 --off \
	--output HDMI-2 --off \
	--output HDMI-3 --off
elif [ "${monitor_count}" == "2" ]; then
	# --output HDMI-1 --primary --mode 3840x2160 --pos 0x0 --rotate normal \
  xrandr \
	--output HDMI-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal \
	--output eDP-1 --mode 2560x1600 --pos 2560x700 --rotate normal \
	--output DP-1 --off \
	--output DP-2-1 --off \
	--output DP-2-2 --off \
	--output DP-2-3 --off \
	--output DP-3 --off \
	--output DP-4 --off \
	--output HDMI-2 --off \
	--output HDMI-3 --off
else
  xrandr \
	--output eDP-1 --primary --mode 2560x1600 --pos 0x0 --rotate normal \
	--output DP-1 --off \
	--output DP-2-1 --off \
	--output DP-2-2 --off \
	--output DP-2-3 --off \
	--output DP-3 --off \
	--output DP-4 --off \
	--output HDMI-1 --off \
	--output HDMI-2 --off \
	--output HDMI-3 --off
fi

/run/current-system/sw/bin/sh ~/.config/polybar/run-polybar.sh
/run/current-system/sw/bin/sh ~/.fehbg

