#!/usr/bin/python

# Created For Solus Operating System

from pisi.actionsapi import get, pisitools, shelltools

NoStrip = ["/usr"]
IgnoreAutodep = True

Version = get.srcVERSION()

def setup():
    shelltools.system("pwd")
    shelltools.system("ar xf filmcraft-%s-linux-x86_64.deb" % Version)
    shelltools.system("tar -xvf data.tar.gz")

def install():
    pisitools.insinto("/", "usr")
