#! /usr/bin/python3

import os, subprocess, mimetypes

for filename in os.listdir():
    mime = subprocess.check_output(
        ['file', '-ib', filename]).decode().split(';')[0]
    print(filename, mime, mimetypes.guess_all_extensions(mime, strict=False),
          sep='\t')

