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
echo "$MUSER ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers
echo "centos ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers
cp /tmp/$KEY* $SSH_DIR 
cat $SSH_DIR/$KEY.pub >> $SSH_DIR/authorized_keys
chmod 600 $SSH_DIR/$KEY
chown $MUSER $SSH_DIR/*
chgrp $MUSER $SSH_DIR/*

sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
service sshd restart
systemctl stop firewalld
systemctl disable firewalld

sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y ansible
sudo yum install -y tmux
sudo yum install -y vim
sudo yum install -y nano
cp $HOME/mosip-infra/deployment/production/mosip/utils/tmux.conf $HOME/.tmux.conf

