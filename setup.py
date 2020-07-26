#!/usr/bin/env python3
#coding:utf-8

import os
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--clean", action="store_true", help="clean links which are set up by this script")
parser.add_argument("--dry-run", action="store_true", help="dry-run")
args = parser.parse_args()

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
    ("git/.gitconfig",             ".gitconfig"),
    ("git/.gitignore_global",      ".gitignore_global"),
    ("ssh",                        ".ssh"),
    ("bash/.bash_profile",         ".bash_profile"),
    ("bash/.bashrc",               ".bashrc"),
    ("mercurial/.hgrc",            ".hgrc"),
    ("mercurial/.hgignore_global", ".hgignore_global"),
    ("zsh/.zshrc",                 ".zsh_rc"),
    ("zsh/.zshenv",                ".zshenv"),
    ("zsh/zfunc",                  ".zfunc"),
]

LINK = list(map(lambda pair: (pair[0], HOME + "/" + pair[1]), LINK))

def main():
    print(args)

    # Remove current exist links.
    for (_, linkTarget) in LINK:
        print("Remove: " + linkTarget)
        try:
            if not args.dry_run:
                os.remove(linkTarget)
        except OSError as e:
            print(e)

    if args.clean:
        return;

    # Make links
    for (src, linkTarget) in LINK:
        src = CURRENT_PATH + "/" + src
        print("Create Symlink (link -> src): " + linkTarget + " -> " + src)

        try:
            if not args.dry_run:
                os.symlink(src, linkTarget)
        except OSError as e:
            print(e)

main()
