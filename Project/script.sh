#!/bin/sh

sudo apt-get update
sudo apt-get install -y ansible

sudo ansible-playbook updateplay.yml
