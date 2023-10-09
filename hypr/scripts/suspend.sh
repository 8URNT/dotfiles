#!/bin/bash
swayidle -w \
timeout 286 'systemctl suspend ' \
before-sleep 'gtklock --time-format %I:%M'
