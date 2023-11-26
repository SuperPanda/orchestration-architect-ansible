## Bootstrap Orchestrator Role

### Overview

The Bootstrap Orchestrator role is a fundamental component for setting up an Arch Linux environment, providing the foundation for diverse use cases such as migrating a physical PC to a headless hypervisor, configuring a nested hypervisor, or enabling PXE boot. Using Ansible, this role orchestrates the initialization process, ensuring a seamless transition to your desired infrastructure configuration.

### Configuration

- **Variables:**
  - `orchestrator_bootstrap_required_pkgs`: A list of required packages for orchestrator bootstrap.
  - `orchestrator_mount_path`: The path where the orchestrator will be mounted.
  - `orchestrator_bootstrap_remote_repo`: The remote repository URL for Ansible playbooks and configurations.
  - `orchestrator_bootstrap_local_repo_path`: The local repository path for Ansible playbooks (optional for local development).
  - `orchestrator_bootstrap_storage_config`: A list of storage volumes to be configured during orchestrator bootstrap.

### Variable Elements

1. `orchestrator_bootstrap_required_pkgs`:
   - Type: List
   - Description: A list of package names required for orchestrator bootstrap.

2. `orchestrator_mount_path`:
   - Type: String
   - Description: The local path where the orchestrator will be mounted.

3. `orchestrator_bootstrap_remote_repo`:
   - Type: String
   - Description: The URL of the remote repository containing Ansible playbooks and configurations.

4. `orchestrator_bootstrap_local_repo_path`:
   - Type: String
   - Description: The local path to the repository for Ansible playbooks (optional for local development).

5. `orchestrator_bootstrap_storage_config`:
   - Type: List
   - Description: A list of storage volumes to be configured during orchestrator bootstrap. Each volume is identified by its name.

### Example Playbook

```yaml
---
- name: Bootstrap Orchestrator
  hosts: localhost
  gather_facts: true
  become: true
  tasks:
    - name: Update Arch Linux Keyring
      community.general.pacman: 
        name: archlinux-keyring
        update_cache: true

    - name: Upgrade Arch Linux packages
      community.general.pacman:
        upgrade: true

    - name: Install required packages
      community.general.pacman:
        name: "{{ item }}"
        state: present
      loop: "{{ orchestrator_bootstrap_required_pkgs }}"

    - name: Create Orchestrator Mount Path
      ansible.builtin.file:
        path: "{{ orchestrator_mount_path }}"
        state: directory
        mode: '0755'

    # Additional tasks specific to your environment

```

### Directory Structure

The orchestrator creates a directory structure during the setup process. This structure is designed to facilitate various use cases, including migrating a physical PC to a headless hypervisor, configuring a nested hypervisor, or enabling PXE boot. When booting from generated images (e.g., USB), the live image loads the storage configuration, allowing the orchestrator to mount the configuration to a RAM-based root filesystem.

### Usage

1. Include the Bootstrap Orchestrator role in your playbook.
2. Set the required variables in the playbook or use external variable files.
3. Run the playbook to bootstrap the orchestrator and prepare the environment for your chosen infrastructure configuration.

### Work in Progress

Efforts are underway to move playbook actions into the role itself, streamlining the orchestration process further. This role serves as a foundational step for various use cases, providing the necessary setup and configuration for subsequent orchestration tasks, whether you're migrating a physical PC to a headless hypervisor, configuring a nested hypervisor, or enabling PXE boot for replication and redundancy scenarios.

