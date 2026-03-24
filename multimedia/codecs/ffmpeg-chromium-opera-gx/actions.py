#!/usr/bin/env python3

# Created For Solus Operating System

from pisi.actionsapi import get, pisitools, shelltools

NoStrip = ["/usr"]
IgnoreAutodep = True

def setup():
    shelltools.system("pwd")
    shelltools.system("unzip 0.%s-linux-x64.zip" % (get.srcVERSION()))

    shelltools.system("7z x *_*_linux_*.crx3")

    # Create widevine_config.json
    shelltools.system("printf '[\n      {\n         \"preload\": \"/usr/lib64/opera-gx-stable/lib_extra/WidevineCdm\"\n      }\n]\n' > widevine_config.json")

    # create directories if not exist
    shelltools.system("mkdir -p /usr/lib64/opera-gx-stable/lib_extra/WidevineCdm/_platform_specific/linux_x64")
    shelltools.system("mkdir -p /usr/lib64/opera-gx-stable/resources")

def install():
    # set libraries and manifest permissions
    shelltools.system("chmod 0644 libffmpeg.so")
    shelltools.system("chmod 0644 _platform_specific/linux_x64/libwidevinecdm.so")
    shelltools.system("chmod 0644 manifest.json")

    # place libraries and json files
    pisitools.insinto("/usr/lib64/opera-gx-stable/lib_extra/", "libffmpeg.so")
    pisitools.insinto("/usr/lib64/opera-gx-stable/lib_extra/WidevineCdm/", "_platform_specific")
    pisitools.insinto("/usr/lib64/opera-gx-stable/lib_extra/WidevineCdm/", "manifest.json")
    pisitools.insinto("/usr/lib64/opera-gx-stable/resources/", "widevine_config.json")
