#!/bin/sh
# This script copies public key to authorized_key file of root
# Assumes that this script is called with 'sudo'
# Parameter: hostname

MUSER=mosipuser
HOME=/home/$MUSER
KEY=id_rsa
hostnamectl set-hostname $1
adduser $MUSER 
chmod 755 $HOME # Needed for nginx access to display files
SSH_DIR=$HOME/.ssh
mkdir -p $SSH_DIR 
chown $MUSER $SSH_DIR 
chgrp $MUSER $SSH_DIR

WURSER=wuri
HOMEWUR=/home/$WURSER
KEY=id_rsa
adduser $WURSER
chmod 755 $HOMEWUR # Needed for nginx access to display files
SSH_DIR_WURI=$HOMEWUR/.ssh
mkdir -p $SSH_DIR_WURI
chown $WURSER $SSH_DIR_WURI
chgrp $WURSER $SSH_DIR_WURI

echo "$MUSER ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers
echo "$WURSER ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers


cp /tmp/$KEY* $SSH_DIR
cp /tmp/$KEY* $SSH_DIR_WURI

cat $SSH_DIR/$KEY.pub >> $SSH_DIR/authorized_keys
cat $SSH_DIR_WURI/$KEY.pub >> $SSH_DIR_WURI/authorized_keys

chmod 600 $SSH_DIR/$KEY
chown $MUSER $SSH_DIR/*
chgrp $MUSER $SSH_DIR/*

chmod 600 $SSH_DIR_WURI/$KEY
chown $WURSER $SSH_DIR_WURI/*
chgrp $WURSER $SSH_DIR_WURI/*

sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
service sshd restart
systemctl stop firewalld
systemctl disable firewalld


