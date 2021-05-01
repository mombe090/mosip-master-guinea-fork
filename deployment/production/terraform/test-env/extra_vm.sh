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


sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
service sshd restart
systemctl stop firewalld
systemctl disable firewalld


