#!/bin/bash

playbook="playbooks/$1"

ansible-playbook -i site.yaml --ask-vault-password --extra-vars '@passwd.yaml' "$playbook"
