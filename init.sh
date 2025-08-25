#!/usr/bin/env bash
set -e

if ! [ -x "$(command -v ansible)" ]; then
    if ! [ -x "$(command -v pip)" ]; then
        if [ "$(which python3)" = /usr/bin/python3 ]; then
            echo "Installing pip for system..."
            sudo apt-get install python3-pip
        else
            echo "Unable to install ansible. Pip is not installed for $(which python3)."
            exit 1
        fi
    fi

    echo "Installing Ansible..."
    python3 -m pip install --break-system-packages ansible
    ansible-galaxy collection install community.general
fi

# Launch playbook at home directory
ansible-playbook --ask-become-pass playbook.yaml
