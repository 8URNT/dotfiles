#!/bin/bash
swayidle -w \
timeout 286 'systemctl suspend ' \
before-sleep 'gtklock'
