# Infrastructure Orchestration with Ansible

## Project Overview

This project leverages Ansible to manage and orchestrate a complex infrastructure on Arch Linux. It includes roles for orchestrating the bootstrap process, managing LUKS keys, handling storage pools, provisioning KVM environments, configuring networks, and generating custom bootable Linux files. The project structure is designed for modularity, allowing easy configuration through variable files.

## Project Structure

```
project_root/
│
├── playbooks/
│   └── ... (list of playbooks)
│
├── roles/
│   └── ... (list of roles)
│
├── vars/
│   └── ... (list of variable files)
│
├── templates/
│   └── ... (list of template files)
│
├── files/
│   └── ... (list of files)
│
├── vault/
│   └── ... (list of vault files)
│
└── 00-bootstrap_orchestrator.sh
```

## Roles Overview

- **orchestration_bootstrap:** Initializes orchestration and coordinates subsequent roles.
- **luks_key_management:** Manages LUKS keys, generating and storing them securely.
- **storage_pool_management:** Handles storage pool configurations, including disks and volumes.
- **kvm_provision:** Manages KVM environments, defining domains, hosts, and networks.
- **network_provision:** Configures network topology, Open vSwitch, VLANs, etc.
- **archiso_provision:** Generates custom bootable Linux files, such as iPXE, ISO, and live images.

## System Diagram

![Orchestrator Architect System Diagram](system_diagram.png)

## Usage

1. Clone the repository.
2. Customize bootstrap_vars.yml and other variable files in the vars/ directory.
3. Run 00-bootstrap_orchestrator.sh to initiate the orchestration process.

### Getting Started

#### Clone the Repository:

```bash
git clone https://github.com/SuperPanda/orchestration-architect-ansible.git
cd orchestration-architect-ansible
```

#### Configure Bootstrap Variables:

Update vars/bootstrap_vars.yml with relevant configuration for orchestration.

#### Run the Orchestration Bootstrap:

```bash
./00-bootstrap_orchestrator.sh
```

#### Further Configuration:

Customize the roles and configurations in the vars directory based on your infrastructure requirements.

## Contributing

Contributions are welcome! Feel free to open issues, submit pull requests, or provide feedback.

## Current Status

As of the latest update, the project has achieved significant milestones:

- **Bootstrap Role: Functional**, handling the initialization of the orchestrator.

- **Encrypted Block Device Provisioning:** Deprecated, managing the lifecycle of encrypted block devices.

- **KVM Provisioning:** Functional, allowing the definition and management of KVM-based virtual machines.

- **Network Provisioning:** Functional, configuring OpenvSwitch bridges and ports based on the defined network topology.

- **Archiso Provisioning:** Functional, generating custom bootable Linux images for deployment.

- **LUKS Key Management:** Operational, managing LUKS encryption keys for secure storage.

## System Design Considerations

### Flexibility and Extensibility

The project prioritizes flexibility and extensibility to accommodate diverse infrastructure requirements. Each role is modular, allowing users to adapt and expand functionality as needed.

### Security

Security is a core consideration, especially in roles like `enc_blkdev_provision` and `luks_key_management`. The project aims to ensure the secure management of encrypted data and encryption keys.

## License

This project is licensed under the MIT License.


