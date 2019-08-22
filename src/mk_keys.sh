#!/bin/bash
ssh-keygen -C deploy -P "" -f ../ansible/roles/ssh/files/deploy_rsa
cp ../ansible/roles/ssh/files/deploy_rsa* ../ansible/roles/ansible/files/roles/ssh/files/
