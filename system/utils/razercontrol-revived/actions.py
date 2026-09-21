#!/usr/bin/python

# Created For Solus Operating System

from pisi.actionsapi import get, pisitools, shelltools

NoStrip = ["/etc", "/usr"]
IgnoreAutodep = True

Version = get.srcVERSION()

def setup():
    shelltools.system("pwd")
    shelltools.system("ar xf razercontrol-revived_%s_amd64.deb" % Version)
    shelltools.system("tar --zstd -xvf data.tar.zst")

def install():
    pisitools.insinto("/", "etc")
    pisitools.insinto("/", "usr")
