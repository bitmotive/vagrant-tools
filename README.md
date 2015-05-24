Vagrant Box Build Instructions:

1. Prepare VirtualBox by adding vbox0 interface

$ bash virtualbox_settings_configuration.sh

2. Install EL6 Minimal ISO image in VirtualBox

   - Specify network settings for eth0 during CentOS Install Wizard process 
   - Configure VirtualBox settings to have second network interface (host-only adapter)
   - Create a ifcfg-eth1 script for managing the host-only adapter interface
   - service network restart and verify IP addresses exist for both eth0 and eth1
   - rm /etc/udev/rules.d/*.rules

3. Run el6_vagrant_configuration.sh on EL6 VM

$ scp el6_vagrant_configuration.sh root@x.x.x.x:/root/.
$ ssh root@x.x.x.x
$ bash /root/el6_vagrant_prep.sh

When prompted, use the VirtualBox GUI to insert the Guest Additions CD.

4. Run the vagrant packager to create a new box

$ bash package_vagrantbox.sh 
