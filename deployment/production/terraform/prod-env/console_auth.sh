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

echo "alias an='ansible-playbook -i hosts.ini'" >> $HOME/.bashrc
echo "alias kc1='kubectl --kubeconfig $HOME/.kube/mzcluster.config'" >> $HOME/.bashrc
echo "alias kc2='kubectl --kubeconfig $HOME/.kube/dmzcluster.config'" >> $HOME/.bashrc
echo "alias sb='cd $HOME/mosip-infra/deployment/production/'" >> $HOME/.bashrc
echo "alias helm1='helm --kubeconfig $HOME/.kube/mzcluster.config'" >> $HOME/.bashrc
echo "alias helm2='helm --kubeconfig $HOME/.kube/dmzcluster.config'" >> $HOME/.bashrc
echo "alias helmm='helm --kubeconfig $HOME/.kube/mzcluster.config -n monitoring'" >> $HOME/.bashrc
echo "alias kcm='kubectl -n monitoring --kubeconfig $HOME/.kube/mzcluster.config'" >> $HOME/.bashrc

source ~/.bashrc
