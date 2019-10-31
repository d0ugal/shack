#!/bin/bash
set -eux
set -o pipefail

sudo dnf upgrade -y;

sudo dnf install -y ansible;

ansible-galaxy install avanov.pyenv;

ansible-playbook main.yml -K;