#!/bin/bash
set -eux
set -o pipefail


if dpkg -s ansible;
then
    echo "Ansible installed";
else
    sudo apt install -y ansible;
fi

ansible-galaxy install -r requirements.yml;

ansible-playbook main.yml -K --verbose;
