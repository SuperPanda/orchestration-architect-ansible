# Arch ISO Provision Role

## Overview

The Arch ISO Provision role automates the process of creating custom Arch Linux ISO images with specific configurations. This role utilizes the `mkarchiso` tool to build ISO images based on a customizable profile. It allows users to define various parameters such as the ISO name, profile settings, SSH keys, and packages to be included in the ISO.

## Configuration

- **Variables:**
  - `arch_linux_provision_iso_name`: Name of the resulting ISO file.
  - `arch_linux_provision_iso_profile`: Profile name for the Arch Linux ISO.
  - `arch_linux_provision_iso_label`: Label assigned to the ISO.
  - `arch_linux_provision_iso_install_dir`: Directory for installing the ISO.
  - `arch_linux_provision_iso_website`: URL associated with the ISO project.
  - `arch_linux_provision_project_name`: Name of the Arch Linux project.
  - `arch_linux_provision_projects_path`: Path to the projects directory.
  - `arch_linux_provision_keys_location`: Path to the directory containing SSH keys.
  - `arch_linux_provision_key_type`: Type of SSH key to generate (e.g., rsa, ed25519).
  - `arch_linux_provision_packages`: List of packages to include in the ISO.
  - `arch_linux_provision_profile_name`: Name of the Arch Linux profile.
  - `arch_linux_provision_src_profile_configs_path`: Path to the source profile configuration.
  - `arch_linux_provision_profiles_directory`: Directory for storing profiles.
  - `arch_linux_provision_output_directory`: Directory for the output (resulting ISO).
  - `arch_linux_provision_work_directory`: Directory for temporary work files.

## Example Playbook

```yaml
---
- name: Arch ISO Provisioning
  hosts: localhost
  gather_facts: true
  become: true
  tasks:
    - name: Manage Arch ISO
      include_role:
        name: archiso_provision
```

## Tasks Explanation

1. **Set Facts for Arch Linux Provision:**
   - Sets various facts required for Arch Linux ISO provisioning, including ISO name, profile settings, project paths, SSH keys, and packages.

2. **Set Project Relative Facts:**
   - Sets facts related to project paths, including profile, output, and work directories.

3. **Remove Directories:**
   - Deletes existing directories related to the profile, output, and work paths.

4. **Create Directories:**
   - Creates necessary directories for the project, SSH keys, profile, output, and work paths.

5. **Copy Arch ISO Build Profile:**
   - Copies the Arch ISO build profile from the source to the destination.

6. **Generate SSH Key Pair:**
   - Generates an SSH key pair of the specified type (e.g., rsa, ed25519).

7. **Create SSH Directories:**
   - Creates directories for SSH usage on the live image.

8. **Copy Authorized SSH Keys:**
   - Copies authorized SSH keys to the live image's SSH directory.

9. **Create Profiledef.sh:**
   - Creates the `profiledef.sh` file based on the provided template.

10. **Build Image:**
    - Builds the Arch Linux ISO image using the `mkarchiso` tool.

### Usage

1. Include the Arch ISO Provision role in your playbook.
2. Set the required variables in the playbook or use external variable files.
3. Run the playbook to provision a custom Arch Linux ISO based on the provided configurations.

## Note

Ensure that the necessary dependencies, including `mkarchiso` and required packages, are installed on the target system. Customize the variables according to your specific ISO provisioning requirements.

### Recommendations

It is recommended to review the generated `profiledef.sh` and adjust the variables to match your specific use case. Additionally, confirm that the specified paths for SSH keys and package lists are accurate.

## License

This role is released under the [MIT License](LICENSE). Contributions and issue reports are welcome on the [GitHub repository](https://github.com/SuperPanda/orchestration-architect-ansible).

