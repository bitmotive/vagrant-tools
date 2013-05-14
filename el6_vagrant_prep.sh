#!/bin/bash +x

#This configuration script will prepare a 
#CentOS, RHEL, ScientificLinux, or Oracle Linux
#machine for building as a custom vagrant box.


# Update the OS 
yum -y update

# Disable SELinux
cd /etc/selinux
setenforce 0
sed -e "s/^SELINUX=.*$/SELINUX=disabled/" config > config.bak && mv config.bak config 
cd /root

# Add and Configure vagrant SSH Login
groupadd admin
groupadd sshusers
useradd -G admin,sshusers vagrant
echo "vagrant" | passwd vagrant --stdin

# Install sudo command
yum -y install sudo

# Edit sudoers file
if [ -f "/etc/sudoers.tmp" ]; then
    echo "ERROR: sudoers file is in use!"
    exit 1
fi

touch /etc/sudoers.tmp
cp -f /etc/sudoers /tmp/sudoers.new

#Visudo changes
sed -i 's/^Defaults\s*requiretty/\#&/' /tmp/sudoers.new
sed -i 's/^Defaults\s*!visiblepw/\#&/' /tmp/sudoers.new

grep 'Allow admin users to sudo without password' /tmp/sudoers.new
if [ "$?" -ne "0" ]; then
    echo "#Allow admin users to sudo without password (for vagrant)" >> /tmp/sudoers.new 
    echo "%admin ALL=NOPASSWD:ALL" >> /tmp/sudoers.new
fi

visudo -c -f /tmp/sudoers.new
if [ "$?" -eq "0" ]; then
    cp /tmp/sudoers.new /etc/sudoers
fi
rm /etc/sudoers.tmp


#Add "Insecure" Vagrant Keys
cd /home/vagrant
mkdir .ssh
curl -k https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub > .ssh/authorized_keys
chown -R vagrant .ssh
chgrp -R vagrant .ssh
chmod 0755 .ssh
chmod 0644 .ssh/authorized_keys
cd /root

#Install VirtualBox Guest Addition Dependencies
echo -n "Install VirtualBox Guest Additions? [y/N]: "
read GUEST_FLAG

if [ $GUEST_FLAG == "y" ]; then
    yum -y groupinstall "Development Tools"
    yum -y install kernel-devel

    echo "Insert the VirtualBox Guest Additions CD-ROM"
    read -p "Press the [Enter] key to continue..."
    
    mkdir /media/cdrom
    mount -r /dev/cdrom /media/cdrom
    bash /media/cdrom/VBoxLinuxAdditions.run
fi

echo -n "Do you want to install Puppet? [y/N]: "
read PUPPET_FLAG

if [ $PUPPET_FLAG == "y" ]; then
    rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm
    yum -y install puppet
fi
