#!/usr/bin/env python3
# -*- coding: utf-8 -*-

fg = '\033[38;5;'
bg = '\033[48;5;'
clear = '\033[0m'

for n in range( 0, 256):
  fgstr = '{fg}{n}m{n}'.format(fg=fg, n=n)
  bgstr = '{bg}{n}mXXX'.format(bg=bg, n=n)
  print (fgstr, bgstr, clear, end=' ')
