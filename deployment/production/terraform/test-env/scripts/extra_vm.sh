#!/bin/sh
# This script copies public key to authorized_key file of root
# Assumes that this script is called with 'sudo'
# Parameter: hostname

sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
service sshd restart
systemctl stop firewalld
systemctl disable firewalld
