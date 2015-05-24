#!/bin/bash

# Simple script to save on syntax-checking later.

usage() { echo "Usage: $0 [-b <string>] [-t <string>] [-o <string>]" 1>&2; exit 1; }

#Name of the *.vbox file to package
VBOX_NAME=
#Name of Vagrantfile template
VAGRANT_FILE=
#Name of *.box file generated
OUTPUT_FILE=

while getopts "b:t:o:" OPTION
do
    case $OPTION in 
        b)
            VBOX_NAME=$OPTARG
            ;;
        t)
            VAGRANT_FILE=$OPTARG
            ;;
        o)
            OUTPUT_FILE=$OPTARG
            ;;
        ?)
            usage
            ;;
    esac
done

if [ -z $VBOX_NAME ]
then
  echo -n "VirtualBox Name (e.g. Bitmotive/Centos6.5-64bit-BASE): "
  read VBOX_NAME
fi

if [ -z $VAGRANT_FILE ]
then
  echo -n "Vagrant File Template path (e.g. Vagrantfile-template): "
  read VAGRANT_FILE
fi

if [ -z $OUTPUT_FILE ]
then
  echo -n "Vagrant Box Output Filename (e.g. centos-6.5-64bit-BASE.box): "
  read OUTPUT_FILE
fi

vagrant package --vagrantfile $VAGRANT_FILE --base $VBOX_NAME --output $OUTPUT_FILE
