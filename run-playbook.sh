#!/bin/bash

playbook="playbooks/$1"

ansible-playbook -v -i site.yaml --ask-vault-password --extra-vars '@passwd.yaml' "$playbook"
