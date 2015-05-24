#!/usr/bin
# This script will tweak a few VirtualBox
# settings to enhance our workflow.
# It should only be run once.

# Add vbox0 host-only adapter for emulating VLAN
# and controlling IP Addresses in development.
VBoxManage hostonlyif create
