#!/bin/sh
# This script copies public key to authorized_key file of root
# Assumes that this script is called with 'sudo'
# Parameter: hostname

CUSER=centos
HOME=/home/$CUSER
KEY=id_rsa
hostnamectl set-hostname $1
SSH_DIR=$HOME/.ssh
mkdir -p $SSH_DIR 
chown $CUSER $SSH_DIR 
chgrp $CUSER $SSH_DIR 
echo "$CUSER ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers
cp /tmp/$KEY* $SSH_DIR 
cat $SSH_DIR/$KEY.pub >> $SSH_DIR/authorized_keys
chmod 600 $SSH_DIR/$KEY
chown $CUSER $SSH_DIR/*
chgrp $CUSER $SSH_DIR/*
# Mount EBS volume.
# CAUTION: the partition name is hardcoded. It may change.
mkfs -t xfs /dev/nvme1n1
mount /dev/nvme1n1 /srv
# Make the above permanent
echo "/dev/nvme1n1 /srv                       xfs     defaults        0 0" >> /etc/fstab
sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
service sshd restart
systemctl stop firewalld
systemctl disable firewalld


