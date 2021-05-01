#!/bin/sh
# This script copies public key to authorized_key file of root
# Paramenter: hostname

KEY=/tmp/id_rsa.pub
hostnamectl set-hostname $1
mkdir -p /root/.ssh
cat $KEY >> /root/.ssh/authorized_keys
sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
service sshd restart
systemctl stop firewalld
systemctl disable firewalld