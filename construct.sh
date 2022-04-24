#!/bin/bash

set -eux
set -o pipefail


if command -v ansible-playbook &> /dev/null;
then
    echo "Ansible installed";
else
    sudo dnf install -y ansible;
fi

/usr/bin/python3 /usr/bin/ansible-galaxy install -r requirements.yml --force;

/usr/bin/python3 /usr/bin/ansible-playbook main.yml -K --verbose $@;
