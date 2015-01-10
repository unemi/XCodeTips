#! /bin/csh
# Makes PNG files for OS X's icon set by just scaling down from
# a source image file "icon_512x512@2x.png" in the current directory.
# by Tatsuo Unemi
# This script assumes netpbm library and commands are installed.
#
set path=($path /usr/local/netpbm/bin)
setenv DYLD_LIBRARY_PATH /usr/local/netpbm/lib
if (-f icon_512x512@2x.png) then
pngtopam -alpha icon_512x512@2x.png > alpha1024.pgm
pngtopam -mix icon_512x512@2x.png > rgb1024.pnm
set a = 1024
foreach s (512 256 128 64 32 16)
if (-f icon_${s}x${s}.png) then
  pngtopam -alpha icon_${s}x${s}.png > alpha${s}.pgm
  pngtopam -mix icon_${s}x${s}.png > rgb${s}.pnm
else
  pamscale 0.5 alpha${a}.pgm > alpha${s}.pgm
  pamscale 0.5 rgb${a}.pnm | pnmquant 2048 > rgb${s}.pnm
endif
set a = $s
end
foreach s (512 256 128 32 16)
if (! -f icon_${s}x${s}.png) then
  pnmtopng -alpha alpha${s}.pgm rgb${s}.pnm > icon_${s}x${s}.png
endif
@ a = $s * 2
if (! -f icon_${s}x${s}@2x.png) then
  pnmtopng -alpha alpha${a}.pgm rgb${a}.pnm > icon_${s}x${s}@2x.png
endif
end
rm alpha*.pgm rgb*.pnm
endif
