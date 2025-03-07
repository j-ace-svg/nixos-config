#!/bin/sh

# Make script fail if any individual commands fail
set -e

sudo modprobe -r psmouse
echo Resetting...
sleep 3
sudo modprobe psmouse
