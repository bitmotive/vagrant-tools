#!/bin/bash

# Simple script to save on syntax-checking later.

#This should be the name of VM instance 
#as listed in the VirtualBox GUI. 
#AS OF Oct. 2013, SPACES WITHIN THE NAME CAUSE AN ERROR
echo -n "VirtualBox Name: "
read VBOX_NAME

#This is a filepath to a templated Vagrantfile to be included
echo -n "Vagrant File Template path: "
read VAGRANT_FILE

#The vagrant box file that will be created.
echo -n "Output Filename: "
read OUTPUT_FILE

vagrant package --vagrantfile $VAGRANT_FILE --base $VBOX_NAME --output $OUTPUT_FILE
