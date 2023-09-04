#!/bin/bash
swayidle -w \
timeout 120 'systemctl suspend ' \
before-sleep 'gtklock'
