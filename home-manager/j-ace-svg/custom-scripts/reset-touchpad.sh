#!/bin/sh

# Make script fail if any individual commands fail
set -e

sudo modprobe -r psmouse
sudo modprobe psmouse
