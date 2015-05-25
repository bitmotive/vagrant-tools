# Vagrant Tools

A collection of tools for building custom Vagrant boxes and managing development environments with Vagrant.

## Project Overview

### scripts/el6_vagrant_configuration.sh

This script will prepare a Centos 6.5/6.6 VM image in VirtualBox for
packaging as a Vagrant box. It will update system software, create 
the vagrant user, and install the VirtualBox guest additions. Proper 
installation of the guest additions is vital for being able to mount 
shared folders later.

### scripts/package_vagrantbox.sh

This script is a wrapper around the basic vagrant CLI commands used to take 
VM from VirtualBox and convert it to a Vagrant box.

### scripts/virtualbox_settings_configuration.sh

Small script that should be run after first installing VirtualBox to quickly
make required VirtualBox configurations easy and replicable. Currently 
responsible for creating a host-only adapter to be used for private VLANs.

### vagrantfiles/*

Collection of Vagrant files to be included by default when building a Vagrant
box.

## Instructions for Building a Vagrant Box 

1. Prepare VirtualBox by adding vbox0 interface
    
    ```shell
    $ bash virtualbox_settings_configuration.sh
    ```
    
    Only run this command one time per VirtualBox installation.
    
2. Install EL6 Minimal ISO image in VirtualBox
    
      * Download Centos 6.6 minimal ISO from mirror (always checksum).
      * Configure VM to have primary (eth0) and secondary (eth1) interfaces. 
        The eth0 interface should be setup as the VLAN and tied to the host-only
        adapter, while eth1 should be setup as the "public" bridged adapter or 
        NAT'd against the host OS. You will need to create teh ifcfg-eth1 script
        manually.
      * run `service network restart` and verify IP addresses exist for both eth0 and eth1
      * On Centos 6.5/6.6, run `rm /etc/udev/rules.d/*.rules` to delete udev rules.
    
3. Run el6_vagrant_configuration.sh on EL6 VM
    
    ```shell
    $ scp el6_vagrant_configuration.sh root@x.x.x.x:/root/.
    $ ssh root@x.x.x.x
    $ bash /root/el6_vagrant_configuration.sh
    ```
    
4. Run the vagrant packager to create a new box
    
    ```shell
    $ bash package_vagrantbox.sh 
    ```
