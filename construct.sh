#!/bin/bash
set -eux
set -o pipefail

sudo dnf install -y ansible;

ansible-galaxy install -r requirements.yml;

ansible-playbook main.yml -K;
