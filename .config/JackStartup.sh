#!/bin/bash

pacmd load-module module-jack-source channels=2
pacmd load-module module-jack-sink channels=2
pacmd load-module module-loopback source=jack_in sink=alsa_output.pci-0000_00_1f.3.analog-stereo channels=2

