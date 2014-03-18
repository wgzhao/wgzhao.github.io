#!/usr/bin/python -tt
# -*- coding:utf-8 -*-
'''
调整屏幕的亮度，接受两个参数down,up
'''
__URL__ = "http://blog.wgzhao.com"
import sys
from os import system
CONF = "/proc/acpi/video/IGFX/LCD/brightness"
def main():
    try:
        arg = sys.argv[1]
    except IndexError:
        arg = "down"
    (levels,cur) = open(CONF,'r').readlines()
    levels = levels.split(':')[1].strip().split()
    cur  = cur.split(':')[1].strip()
    index = levels.index(cur)
    if arg == "down":
        newcur = levels[index - 1]
    elif arg == "up":
        newcur = levels[index + 1 ]
    system('echo %d > %s' % (int(newcur),CONF))
    return 0
if __name__ == "__main__":

    sys.exit(main())