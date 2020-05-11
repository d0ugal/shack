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

# Restart i3 with; ./construct.sh -e "i3_restart=True"
# Reinstall pipx packages with; ./construct.sh -e "pipx_clean=True"
# Update the mirrored repos with; ./construct.sh -e "cloneall=True"
ansible-playbook main.yml -K --verbose $@;
