# Source for colors: . ansi.sh

bgbla='[40m'; bgred='[41m'; bggre='[42m'; bgbro='[43m';
bgblu='[44m'; bgmag='[45m'; bgcya='[46m'; bggra='[47m';
bla='[30m'; red='[31m'; gre='[32m'; bro='[33m';
blu='[34m'; mag='[35m'; cya='[36m'; gra='[37m';
bbla='[30;1m'; bred='[31;1m'; bgre='[32;1m'; yel='[33;1m';
bblu='[34;1m'; bmag='[35;1m'; bcya='[36;1m'; whi='[37;1m';
rst='[0m'; inv='[7m'; cll='[2K'; cllr='[K';
cls='[2J'; clsb='[J'; 
# Dark variants (256-color codes)
bgbluk='[48;5;18m'
bgredk='[48;5;52m'

ahome="[1H";
# Special font attributes
bo_s="[1m"; bo_e="[22m";
faint_s="[2m"; faint_e="[22m";
it_s="[3m"; it_e="[23m";
boit_s="[1m[3m"; boit_e="[22m[23m";
un_s="[4m"; un_e="[24m";
dun_s="[21m"; dun_e="[24m";
curly_un_s="[4:3m"; curly_un_e="[24m";
dot_un_s="[4:4m"; dot_un_e="[24m";
dash_un_s="[4:5m"; dash_un_e="[24m";
oline_s="[53m"; oline_e="[55m";
strikethru_s="[9m"; strikethru_e="[29m";
inv_s="[7m"; inv_e="[27m";
heavy_s="[1;2m"; heavy_e="[22m";
cursor_hide="[?25l";
cursor_show="[?25h";
# Scroll regions: String versions
screg_tb_s() { echo "[$1;${2}r"; }
screg_rst="[r";

# Usable with echo -e and printf:
bgblae='\e[40m'; bgrede='\e[41m'; bggree='\e[42m'; bgbroe='\e[43m';
bgblue='\e[44m'; bgmage='\e[45m'; bgcyae='\e[46m'; bggrae='\e[47m';
blae='\e[30m'; rede='\e[31m'; gree='\e[32m'; broe='\e[33m';
blue='\e[34m'; mage='\e[35m'; cyae='\e[36m'; grae='\e[37m';
bblae='\e[30;1m'; brede='\e[31;1m'; bgree='\e[32;1m'; yele='\e[33;1m';
bblue='\e[34;1m'; bmage='\e[35;1m'; bcyae='\e[36;1m'; whie='\e[37;1m';
rste='\e[0m'; inve='\e[7m'; clle='\e[2K'; cllre='\e[K';
clse='\e[2J'; clsbe='\e[J';


hex2rgb () {
	local hex="${1#\#}"
	local r g b
	r=$((16#${hex:0:2}))
	g=$((16#${hex:2:2}))
	b=$((16#${hex:4:2}))
	echo "$r" "$g" "$b"
}

a24fghex () { # Usage: a24fghex [#]rrggbb
	local hex="${1#\#}" # Remove leading '#' if present
	local r g b
	r=$((16#${hex:0:2})) # Extract and convert red
	g=$((16#${hex:2:2})) # Extract and convert green
	b=$((16#${hex:4:2})) # Extract and convert blue
	a24fg "$r" "$g" "$b"
}
a24bghex () { # Usage: a24bghex [#]rrggbb
	local hex="${1#\#}" # Remove leading '#' if present
	local r g b
	r=$((16#${hex:0:2})) # Extract and convert red
	g=$((16#${hex:2:2})) # Extract and convert green
	b=$((16#${hex:4:2})) # Extract and convert blue
	a24bg "$r" "$g" "$b"
}
a24fg () { # [0-255] Usage: a24fg r g b
	printf '%s' "[38;2;$1;$2;${3}m"
}
a24bg () { # [0-255] Usage: a24fg r g b
	printf '%s' "[48;2;$1;$2;${3}m"
}
ansi_uncolor () {
	bgbla=''; bgred=''; bggre=''; bgbro='';
	bgblu=''; bgmag=''; bgcya=''; bggra='';
	bla=''; red=''; gre=''; bro='';
	blu=''; mag=''; cya=''; gra='';
	bbla=''; bred=''; bgre=''; yel='';
	bblu=''; bmag=''; bcya=''; whi='';
	rst=''; inv=''; cll=''; cllr='';
	cls=''; clsb=''; 
	ahome='';
	bo_s=''; bo_e='';
	faint_s=''; faint_e='';
	it_s=''; it_e='';
	boit_s=''; boit_e='';
	un_s=''; un_e='';
	dun_s=''; dun_e='';
	curly_un_s=''; curly_un_e='';
	dot_un_s=''; dot_un_e='';
	dash_un_s=''; dash_un_e='';
	oline_s=''; oline_e='';
	strikethru_s=''; strikethru_e='';
	inv_s=''; inv_e='';
	heavy_s=''; heavy_e='';
	cursor_hide='';
	cursor_show='';
	screg_rst='';
	unset screg_tb_s a24fg a24bg
}
