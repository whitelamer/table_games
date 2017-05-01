export `xinput | grep Touchscreen | cut -f 2`
export screen=`xrandr | grep primary | cut -d ' ' -f 1`
xinput --map-to-output $id $screen
xinput set-int-prop $id "Evdev Axis Calibration" 32 1581 398 642 1330
xinput set-int-prop $id "Evdev Axes Swap" 8 0



xinput --map-to-output 9 VGA-0
xinput set-int-prop 9 "Evdev Axis Calibration" 32 1581 398 642 1330
xinput set-int-prop 9 "Evdev Axes Swap" 8 0
