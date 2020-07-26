#!/usr/bin/env python
#coding:utf-8

import os

CURRENT_PATH = os.getcwd()
HOME = os.environ["HOME"]
XDG_CONFIG_HOME = ""
try:
    XDG_CONFIG_HOME = os.environ["XDG_CONFIG_HOME"]
except KeyError as e:
    XDG_CONFIG_HOME = HOME + "/.config"

print("$CURRENT_PATH: " + CURRENT_PATH)
print("$HOME: " + HOME)
print("$XDG_CONFIG_HOME: " + XDG_CONFIG_HOME)

LINK = [
    ("git/.gitconfig",           HOME + "/.gitconfig"),
    ("git/.gitignore_global",    HOME + "/.gitignore_global"),

    ("ssh",                 HOME + "/.ssh"),
]

# Remove current exist links.
for (_, linkTarget) in LINK:
    try:
        os.remove(linkTarget)
        print("Remove: " + linkTarget)
    except OSError as e:
        print(e)

# Make links
for (src, linkTarget) in LINK:
    src = CURRENT_PATH + "/" + src
    print("Create Symlink (link -> src): " + linkTarget + " -> " + src)

    try:
        os.symlink(src, linkTarget)
    except OSError as e:
        print(e)
