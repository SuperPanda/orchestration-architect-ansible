#!/bin/bash

echo "Welcome to the Ansible Setup Script!"

# Check if .env file exists
if [ -f .env ] && [ "$1" != "--rerun" ]; then
  echo "Existing configuration found. Use --rerun to force reconfiguration."
else
  # Prompt the user for input only if .env file doesn't exist or --rerun is specified
  read -p "Enter the desired Ansible username (default is 'ansible'): " NEW_ANSIBLE_USER
  ANSIBLE_USER=${NEW_ANSIBLE_USER:-ansible}

  # Set the default SSH public key path
  SSH_PUBLIC_KEY_PATH="/home/$(whoami)/.ssh/ansible_deploy_key.pub"

  read -p "Enter the desired SSH port for Ansible (default is '22'): " NEW_ANSIBLE_SSH_PORT
  ANSIBLE_SSH_PORT=${NEW_ANSIBLE_SSH_PORT:-22}

  read -p "Enter the desired hostname for Ansible (default is 'HostName'): " NEW_ANSIBLE_HOSTNAME
  ANSIBLE_HOSTNAME=${NEW_ANSIBLE_HOSTNAME:-HostName}

  
  # Create or update the .env file
  cat <<EOF >.env
# .env

ANSIBLE_USER=$ANSIBLE_USER
ANSIBLE_PUBLIC_KEY_PATH=$SSH_PUBLIC_KEY_PATH
ANSIBLE_SSH_PORT=$ANSIBLE_SSH_PORT
ANSIBLE_HOSTNAME=$ANSIBLE_HOSTNAME
EOF

  echo "Configuration saved to .env file."
fi

# Set the deploy key path
DEPLOY_KEY_PATH="/home/$(whoami)/.ssh/ansible_deploy_key"

# Check if the SSH key exists
if [ ! -f "$DEPLOY_KEY_PATH" ]; then
  # Generate the SSH deploy key if it doesn't exist
  echo "Generating SSH deploy key..."
  ssh-keygen -t rsa -b 2048 -f "$DEPLOY_KEY_PATH" -q -N ""
  echo "SSH deploy key generated successfully."
fi

# Start ssh-agent
eval "$(ssh-agent -s)"

# Add the private key to the ssh-agent
ssh-add "$DEPLOY_KEY_PATH"

# Load environment variables from .env file
set -a allexport
source .env
set +o allexport

# Run Ansible playbook with environment variables as extra variables
ansible-playbook -i localhost, playbooks/setup_ansible_user.yml -e "ansible_user=$ANSIBLE_USER ansible_public_key_path=$ANSIBLE_PUBLIC_KEY_PATH ansible_ssh_port=$ANSIBLE_SSH_PORT" --ask-become-pass

#ansible-playbook playbooks/00-bootstrap_orchestrator.yml --extra-vars "new_hostname=$ANSIBLE_HOSTNAME"
