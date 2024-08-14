# Some basic ANSI terminal codes.
# Author: jaggz.h at gmail
# Todo:
#  * The var/routine naming scheme probably sucks. I tried though.
#  * Re-add "disable" routines -- to wipe/reassign variables.
#  * Fix and advance the hackish higher color routines
#    (Only the 256 color set is even basically touched, so far).
# Notes:
#  No value bounds are placed on anything.  Up to the caller for now.
package ansib;

# Gist url: https://gist.github.com/7b22252263719757e17ca710ac091110

#BEGIN { uncolor() if grep {/^(--no-ansi|--color=none)$/} @ARGV; }

use strict; use warnings;
use Exporter 'import';
our @codes = qw(
	$bgbla $bgred $bggre $bgbro
	$bgblu $bgmag $bgcya $bggra
	$bla $red $gre $bro
	$blu $mag $cya $gra
	$bbla $bred $bgre $yel
	$bblu $bmag $bcya $whi
	$rst $inv
	$cll $cllr $cls $clsb
	$ahome
);
our @utils256 = qw(
	fggray_5fl fggray_23
	bggray_5fl bggray_23
	fg_rgb5 bg_rgb5
	fg_rgb5fl bg_rgb5fl
);
our @utils24 = qw(
	fg24 bg24
	a24fg a24bg
);
our @utils = qw( gotoxy gotoxys ansilen uncolor gright gleft gup gdown );
our @EXPORT_OK = (@codes, @utils, @utils256, @utils24);
our %EXPORT_TAGS = (
	codes => [@codes],
	utils => [@utils],
	utils256 => [@utils256], 
	all => [@codes, @utils, @utils256, @utils24],
);
our @EXPORT = (@codes, @utils, @utils24);

# BG
our $bgbla="\033[40m"; our $bgred="\033[41m"; our $bggre="\033[42m";
our $bgbro="\033[43m"; our $bgblu="\033[44m"; our $bgmag="\033[45m";
our $bgcya="\033[46m"; our $bggra="\033[47m";
# FG
our $bla="\033[30m"; our $red="\033[31m"; our $gre="\033[32m";
our $bro="\033[33m"; our $blu="\033[34m"; our $mag="\033[35m";
our $cya="\033[36m"; our $gra="\033[37m";
# Bright FG (FG with intensity)
our $bbla="\033[30;1m"; our $bred="\033[31;1m"; our $bgre="\033[32;1m";
our $yel="\033[33;1m"; our $bblu="\033[34;1m"; our $bmag="\033[35;1m";
our $bcya="\033[36;1m"; our $whi="\033[37;1m";
# Other...
our $rst="\033[0m"; our $inv="\033[7m";
our $cll="\033[2K"; our $cllr="\033[K"; our $cls="\033[2J"; our $clsb="\033[J";
our $ahome = "\033[1H";

sub uncolor {
	$bgbla=$bgred=$bggre='';
	$bgbro=$bgblu=$bgmag='';
	$bgcya=$bggra='';
	$bla=$red=$gre='';
	$bro=$blu=$mag='';
	$cya=$gra='';
	$bbla=$bred=$bgre='';
	$yel=$bblu=$bmag='';
	$bcya=$whi='';
	$rst=$inv='';
	$cll=$cllr=$cls=$clsb='';
	$ahome='';
}

# 24 bit colors
sub fg24 { my ($r,$g,$b) = @_; return "\033[38;2;".$r.";".$g.";".$b."m"; }
sub bg24 { my ($r,$g,$b) = @_; return "\033[48;2;".$r.";".$g.";".$b."m"; }
sub a24fg { fg24 @_; }
sub a24bg { bg24 @_; }

# 0-5 color components for 256 color mode
sub fg_rgb5 {
	warn "0-5 float value high " . join(',',@_) if ($_[0]>5 || $_[1]>5 || $_[2]>5);
		# If they give us a negative number it's their fault...
	"\033[38;5;" . rgb5val(@_) . "m";
}
sub bg_rgb5 {
	warn "0-5 float value high " . join(',',@_) if ($_[0]>5 || $_[1]>5 || $_[2]>5);
		# If they give us a negative number it's their fault...
	"\033[48;5;" . rgb5val(@_) . "m";
}
sub fg_rgb5fl {
	warn "RGB float value high " . join(',',@_) if ($_[0]>1 || $_[1]>1 || $_[2]>1);
		# If they give us a negative number it's their fault...
	"\033[38;5;" . rgb5val(   map { int($_*5) } @_   ) . "m";
}
sub bg_rgb5fl {
	warn "RGB float value high " . join(',',@_) if ($_[0]>1 || $_[1]>1 || $_[2]>1);
		# If they give us a negative number it's their fault...
	"\033[48;5;" . rgb5val(   map { int($_*5) } @_   ) . "m";
}
sub rgb5val {
	my ($r,$g,$b) = @_;
	16 + 36*$r + 6*$g + $b;
}

# 0-23 colors of gray (23 is a reminder)
sub fggray_23 {
	"\033[38;5;" . gray_5_23_val($_[0]) . "m";
}
sub fggray_5fl {
	"\033[38;5;" . gray_5_fl_val($_[0]) . "m";
}
sub bggray_23 {
	"\033[48;5;" . gray_5_23_val($_[0]) . "m";
}
sub bggray_5fl {
	"\033[48;5;" . gray_5_fl_val($_[0]) . "m";
}

sub gray_5_fl_val {
	$_ = shift;
	if ($_ > 31) { $_ = 31; }
	elsif ($_ < 0) { $_ = 0; }
	232+int($_*31);
}

sub gray_5_23_val {
	$_ = shift;
	if ($_ > 31) { $_ = 31; }
	elsif ($_ < 0) { $_ = 0; }
	232+$_;
}

sub gotoxys {
	my ($x,$y) = @_;
	"\033[$y;${x}H";
}

sub gotoxy {
	my ($x,$y) = @_;
	print "\033[$y;${x}H";
}

sub ansilen {
	my $s = shift;
	$s =~ s/\033\[[0-9;]*[a-z]//ig;
	length($s);
}

sub gright { if ($#_ < 0) { print "\033[C" } else { print "\033[$_[0]C" } }
sub gleft { if ($#_ < 0) { print "\033[D" } else { print "\033[$_[0]D" } }
sub gup { if ($#_ < 0) { print "\033[A" } else { print "\033[$_[0]A" } }
sub gdown { if ($#_ < 0) { print "\033[B" } else { print "\033[$_[0]B" } }

if (grep {/^(--no-ansi|--color=none)$/} @ARGV) { @ARGV = grep {!/^(--no-ansi|--color=none)$/} @ARGV; uncolor(); }
1;

return 1;

END {}
