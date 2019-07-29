#!/usr/bin/env python3

from ctypes import cdll, POINTER, c_uint, c_int, Structure
import subprocess


def set_english_kb(layout='en-improved'):
    """Enables English keyboard layout"""
    cmd = ('[ $DISPLAY ] && xkbcomp '
           '-I$HOME/.xkb $HOME/.xkb/keymap/%s $DISPLAY'
           '>/dev/null 2>&1' % layout)
    subprocess.run(cmd, shell=True)


def set_caps_lock_off():
    """Unset caps lock"""
    X11 = cdll.LoadLibrary('libX11.so.6')
    X11.XOpenDisplay.restype = POINTER(type('Display', (Structure, ), {}))
    display = X11.XOpenDisplay(None)
    X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_int(0))
    X11.XCloseDisplay(display)


set_caps_lock_off()
set_english_kb()
