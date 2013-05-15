#!/bin/bash

# Simple script to save on syntax-checking later.

echo -n "VirtualBox Name: "
read VBOX_NAME

echo -n "Vagrant Filename: "
read VAGRANT_FILE

echo -n "Output Filename: "
read OUTPUT_FILE

vagrant package --vagrantfile $VAGRANT_FILE --base $VBOX_NAME --output $OUTPUT_FILE
