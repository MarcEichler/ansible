#!/bin/bash

if [ -z "$1" ]; then
    playbook="site.yml"
else
    playbook="$1"
fi

export LC_ALL=en_US.UTF-8
ansible-playbook -v -i inventory.yml --ask-vault-password --extra-vars '@passwd.yml' "$playbook"
