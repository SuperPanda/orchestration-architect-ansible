# KVM Provision Role

## Overview

The KVM Provision role automates the provisioning of virtual machines (VMs) using KVM (Kernel-based Virtual Machine) on an Arch Linux environment. This role enables users to define and manage VM configurations, including CPU, memory, disk, and network interfaces. It leverages the Libvirt module to interact with the KVM hypervisor.

### Configuration

- **Variables:**
  - `kvm_provision_kernel`: The path to the kernel image for VMs.
  - `kvm_provision_vm_name`: The name assigned to the VM.
  - `kvm_provision_num_cpus`: The number of virtual CPUs allocated to the VM.
  - `kvm_provision_memory`: The initial memory allocated to the VM (in MiB).
  - `kvm_provision_max_memory`: The maximum memory limit for the VM (in MiB).
  - `kvm_provision_disks`: A list of dictionaries defining disk configurations for the VM.
  - `kvm_provision_net_interfaces`: A list of dictionaries specifying network interface configurations for the VM.

## Variable Elements

1. `kvm_provision_kernel`:
   - Type: String
   - Description: Path to the kernel image for the VM.

2. `kvm_provision_vm_name`:
   - Type: String
   - Description: The name assigned to the VM.

3. `kvm_provision_num_cpus`:
   - Type: Integer
   - Description: The number of virtual CPUs allocated to the VM.

4. `kvm_provision_memory`:
   - Type: Integer
   - Description: The initial memory allocated to the VM (in MiB).

5. `kvm_provision_max_memory`:
   - Type: Integer
   - Description: The maximum memory limit for the VM (in MiB).

6. `kvm_provision_disks`:
   - Type: List of Dictionaries
   - Description: A list defining disk configurations for the VM. Each dictionary includes:
     - `src_file`: Path to the source file of the disk.
     - `target_dev`: Target device for the disk.
     - `boot_order`: Boot order for the disk.

7. `kvm_provision_net_interfaces`:
   - Type: List of Dictionaries
   - Description: A list specifying network interface configurations for the VM. Each dictionary includes:
     - `type`: Type of the network interface (e.g., bridge).
     - `mac_address`: MAC address for the network interface.
     - `boot_order`: Boot order for the network interface.
     - `device`: Device associated with the network interface.

## Example Playbook

```yaml
---
- name: KVM Provisioning
  hosts: localhost
  gather_facts: true
  become: true
  tasks:
    - name: Manage KVM VMs
      include_role:
        name: kvm_provision
```

## Tasks Explanation

1. **Manage KVM VMs:**
   - Invokes the KVM Provision role, performing tasks such as defining VMs, ensuring VMs are started, and loading required variables for VM provisioning.

## Usage

1. Include the KVM Provision role in your playbook.
2. Set the required variables in the playbook or use external variable files.
3. Run the playbook to provision KVM VMs based on the provided configurations.

## Note

Ensure that the target system has KVM and Libvirt installed. Customize the `kvm_provision_disks` and `kvm_provision_net_interfaces` variables according to your specific VM provisioning requirements.

## Recommendations

It is recommended to validate the VM configurations and adjust the variables as needed for optimal performance. Additionally, confirm that the specified paths for the kernel and disk source files are accurate.

## License

This role is released under the [MIT License](LICENSE). Contributions and issue reports are welcome on the [GitHub repository](https://github.com/SuperPanda/orchestration-architect-ansible).
