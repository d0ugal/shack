#!/bin/python3

import signal
import subprocess


class Timeout(Exception):
    pass


def timeout(*args, **kwargs):
    raise Timeout()


signal.signal(signal.SIGALRM, timeout)

try:
    signal.alarm(1)
    host = subprocess.check_output(["host", "mail.corp.redhat.com"])
    vpn_connected = b"has address" in host
    signal.alarm(0)
except Timeout:
    vpn_connected = None
except:
    vpn_connected = False

if vpn_connected:
    print("%{u#55aa55}%{F#55AA55} VPN")
else:
    print("%{u#B2535B}%{F#B2535B} VPN")
