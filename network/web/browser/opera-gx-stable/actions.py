#!/usr/bin/env python3

# Created For Solus Operating System

from pisi.actionsapi import get, pisitools, shelltools

NoStrip = ["/usr"]
IgnoreAutodep = True

def setup():
    shelltools.system("pwd")
    shelltools.system("rpm2cpio opera_gx_stable-%s-linux-release-x64-signed.rpm | cpio -idmv" % (get.srcVERSION()))

def install():
    # root owns sandbox as it is setuid
    shelltools.system("chown root:root usr/lib64/opera-gx-stable/opera_sandbox")
    # ensure setuid
    shelltools.system("chmod 4755 usr/lib64/opera-gx-stable/opera_sandbox")

    pisitools.insinto("/", "usr")
