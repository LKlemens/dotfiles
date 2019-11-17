#!/usr/bin/env python

import sys
import time

import daemon

with daemon.DaemonContext(uid=1001, gid=777):
    print(os.getuid())
    print(os.getgid())
