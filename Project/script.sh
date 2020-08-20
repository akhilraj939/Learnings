#!/bin/bash

sudo apt-get update
sudo apt-get install -y ansible
sudo apt-get install -y git
git clone https://github.com/akhilraj939/Learnings.git
cd Learnings/Project

sudo ansible-playbook updateplay.yml
sudo sudo cp -i /etc/kubernetes/admin.conf /home/akhil/.kube/config
sudo chown $(id -u):$(id -g) 
sudo kubectl get -n kube-system pods >> akhil
cat akhil
