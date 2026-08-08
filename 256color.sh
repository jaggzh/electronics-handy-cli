#!/bin/bash
 
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# Original script, I think, was found at:
# https://misc.flogisoft.com/bash/tip_colors_and_formatting
# http://sam.zoy.org/wtfpl/COPYING for more details.
# I added the term sequence code reference. jaggz.h {who is at} gmail"
 
for fgbg in 38 48 ; do #Foreground/Background
	for color in {0..256} ; do #Colors
		#Display the color
		echo -en "\e[${fgbg};5;${color}m ${color}\t\e[0m"
		#Display 10 colors per lines
		if [ $((($color + 1) % 10)) == 0 ] ; then
			echo #New line
		fi
	done
	echo #New line
done
 
echo 'BG: \e[48;5;###m  FG: \e[38;5;###m'
exit 0
