#!/bin/sh
#
# Script that sets up jhbuild for SPICE OS X building. Run this to
# checkout jhbuild and the required configuration.
#
# Copyright 2007, 2008, 2009 Imendio AB
# Copyright 2012 Red Hat, Inc
#
# Run this whenever you want to update jhbuild or the jhbuild setup;
# it is safe to run it repeatedly. Note that it overwrites
# ~/.jhbuildrc however. Custom settings should be kept in
# ~/.jhbuildrc-custom.
#
# You need Mac OS X 10.4 or newer and Xcode 2.5 or newer. Make sure
# you have subversion (svn) installed, 10.5 has it by default.
#
# Quick HOWTO:
#
# sh spice-osx-build-setup.sh
#
# export JHB=spice
# jhbuild bootstrap
# jhbuild build
#
# See http://spice-space.org/page/OSX_Client/Build for more information.
#

SOURCE=$HOME/Source
BASEURL="https://git.gnome.org/browse/gtk-osx/plain/"
SPICE_JHBUILD_GIT="git://people.freedesktop.org/spice/spice-jhbuild"

do_exit()
{
    echo $1
    exit 1
}

if test x`which git` == x; then
    do_exit "Git is not available, please install it and try again."
fi

mkdir -p $SOURCE 2>/dev/null || do_exit "The directory $SOURCE could not be created. Check permissions and try again."

echo "Checking out spice-jhbuild from git..."
if ! test -d $SOURCE/spice-jhbuild; then
    cd $SOURCE
    git clone "$SPICE_JHBUILD_GIT" || do_exit "Failed to clone spice-jhbuild."
    cd spice-jhbuild
    git checkout osx || do_exit "Checkout of osx branch failed";
else
    cd $SOURCE/spice-jhbuild || do_exit "Can't cd to $SOURCE/spice-jhbuild."
    git pull >/dev/null || \
	do_exit "Update of spice-jhbuild failed";
fi

echo "Installing spice-jhbuild configuration..."
if [ ! -f $HOME/.jhbuildrc-spice ]; then
    cp jhbuildrc ~/.jhbuildrc-spice
fi

echo "Setting up gtk-osx build"
cd ..
curl -s $BASEURL/gtk-osx-build-setup.sh -o gtk-osx-build-setup.sh || do_exit "Didn't get jhbuildrc"
sh gtk-osx-build-setup.sh || do_exit "Failed to setup gtk-osx build"
