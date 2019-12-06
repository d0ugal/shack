#!/usr/bin/env python3

import sys
import subprocess
import json

active_window = subprocess.run(
    "xdotool getactivewindow getwindowname", shell=True, capture_output=True
)

# argv looks like this;
# ["/home/dougal/.config/dunst/alert.py", "Shack", "wmcommon", "Starting role.", "dialog-information", "NORMAL"]

app = sys.argv[1]
summary = sys.argv[2]
full_body = sys.argv[3]
icon = sys.argv[4]
level = sys.argv[5]

LOW = "LOW"
NORMAL = "NORMAL"
CRITICAL = "CRITICAL"

# with open("/tmp/dunst-alert-py.log", "a") as f:
#    f.write(str(sys.argv) + "\n")

weechat_active = active_window.stdout.startswith(b"weechat")

if (app == "weechat" and not weechat_active) or level == CRITICAL:
    subprocess.run("paplay /usr/share/sounds/speech-dispatcher/prompt.wav", shell=True)
