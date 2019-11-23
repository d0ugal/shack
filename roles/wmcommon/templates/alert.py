#!/usr/bin/env python3

import sys
import os
import json

# Can we use the following bash and only make the noise if I am not using weechat?
# active_window=$(xdotool getactivewindow getwindowname);

# argv looks like this;
# ["/home/dougal/.config/dunst/alert.py", "Shack", "wmcommon", "Starting role.", "dialog-information", "NORMAL"]

app = sys.argv[1]
summary = sys.argv[2]
full_body = sys.argv[3]
icon = sys.argv[4]
level = sys.argv[5]

if app == "weechat" or level == "CRITICAL"
    os.system("paplay /usr/share/sounds/speech-dispatcher/prompt.wav")