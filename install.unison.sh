#!/bin/bash
#
# Copyright (c) 2015 - 2016 imm studios, z.s.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
##############################################################################
## COMMON UTILS

BASEDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TEMPDIR=/tmp/$(basename "${BASH_SOURCE[0]}")

function error_exit {
    printf "\n\033[0;31mInstallation failed\033[0m\n"
    cd $BASEDIR
    exit 1
}

function finished {
    printf "\n\033[0;92mInstallation completed\033[0m\n"
    cd $BASEDIR
    exit 0
}


if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   error_exit
fi

if [ ! -d $TEMPDIR ]; then
    mkdir $TEMPDIR || error_exit
fi

## COMMON UTILS
##############################################################################

OCAML_VERSION=4.02.3
UNISON_VERSION=2.48.3

function install_ocaml {
    cd $TEMPDIR
    wget http://caml.inria.fr/pub/distrib/ocaml-4.02/${OCAML_VERSION}.tar.gz
    tar -xf ocaml-${OCAML_VERSION}.tar.gz
    cd ocaml-${OCAML_VERSION}

    ./configure
    make world.opt
    make install
}

function install_unison {
    cd $TEMPDIR
    wget http://www.seas.upenn.edu/~bcpierce/unison//download/releases/stable/unison-${UNISON_VERSION}.tar.gz
    tar -xf unison-${UNISON_VERSION}.tar.gz
    cd unison-${UNISON_VERSION}
    make
    cp unison /usr/bin/
}

install_ocaml || error_exit
install_unison || error_exit
unison
