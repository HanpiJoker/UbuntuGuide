#!/bin/bash
ls /dev/ttyUSB* > temp
echo set line `head -1 temp` > .kermrc
rm temp
echo set speed 115200 >> .kermrc
echo set carrier-watch off >> .kermrc
echo set handshake none >> .kermrc
echo set flow-control none >> .kermrc
echo robust >> .kermrc
echo set file type bin >> .kermrc
echo set file name lit >> .kermrc
echo set rec pack 1000 >> .kermrc
echo set send pack 1000 >> .kermrc
echo set window 5 >> .kermrc
echo c >> .kermrc
sudo kermit -c
