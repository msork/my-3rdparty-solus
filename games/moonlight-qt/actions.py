#!/usr/bin/python

# Created For Solus Operating System

from pisi.actionsapi import get, pisitools, shelltools

NoStrip = ["/usr", "/opt"]
IgnoreAutodep = True

Version = get.srcVERSION()

def setup():
    shelltools.system("mkdir -p opt usr/bin usr/share/icons/hicolor usr/share/applications")
    shelltools.system("unsquashfs -o 189632 -f -d squashfs-root Moonlight-%s-x86_64.AppImage" % Version)
    
    shelltools.system("mv squashfs-root/com.moonlight_stream.Moonlight.desktop squashfs-root/moonlight-qt.desktop")
    shelltools.system("sed -i '/AppImage/d' 'squashfs-root/moonlight-qt.desktop'")
    shelltools.system("cp squashfs-root/moonlight-qt.desktop usr/share/applications/")
    shelltools.system("cp -r squashfs-root opt/moonlight-qt")
    shelltools.system("cp squashfs-root/AppRun opt/moonlight-qt/AppRun")
    shelltools.system("cp -r squashfs-root/usr/share/icons/hicolor/ usr/share/icons/")
    shelltools.system("printf '%s\\n' '#! /bin/sh' 'cd /opt/moonlight-qt/' 'exec /opt/moonlight-qt/usr/bin/moonlight \"$@\"' > \"usr/bin/moonlight\" && chmod +x \"usr/bin/moonlight\"")
    
    shelltools.system("rm -rf squashfs-root")
    
def install():
    pisitools.insinto("/", "usr")
    pisitools.insinto("/", "opt")    
