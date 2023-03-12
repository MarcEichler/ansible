#!/bin/bash

if [ -z "$1" ]; then
    playbook="site.yml"
else
    playbook="$1"
fi

ansible-playbook -v -i inventory.yml --ask-vault-password --extra-vars '@passwd.yml' "$playbook"
