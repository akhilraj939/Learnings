#!/bin/bash

sudo apt-get update
sudo apt-get install -y ansible
sudo apt-get install -y git
git clone https://github.com/akhilraj939/Learnings.git
cd Learnings/Project

sudo ansible-playbook updateplay.yml
