#!/bin/bash
set -eux
set -o pipefail


if rpm -q --quiet ansible;
then
    echo "Ansible installed";
else
    sudo dnf install -y ansible;
fi

ansible-galaxy install -r requirements.yml;

ansible-playbook main.yml -K;
