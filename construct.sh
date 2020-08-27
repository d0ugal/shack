#!/bin/bash

set -eux
set -o pipefail


if dpkg -s ansible;
then
    echo "Ansible installed";
else
    sudo apt install -y ansible;
fi

/usr/bin/python3 /usr/bin/ansible-galaxy install -r requirements.yml;

# Do additional slower tasks with; ./construct.sh -e "slow=True"
# Do additional even slower tasks with; ./construct.sh -e "very_slow=True"
/usr/bin/python3 /usr/bin/ansible-playbook main.yml -K --verbose $@;
