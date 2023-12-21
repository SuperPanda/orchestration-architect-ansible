# LUKS Key Management Role

## Overview

The LUKS Key Management role is a comprehensive tool for managing LUKS (Linux Unified Key Setup) encryption within an Arch Linux environment. This role facilitates the creation, opening, and closing of LUKS containers, in addition to generating, adding, and managing LUKS keys for various storage entities.

## Configuration

- **Variables:**
  - `luks_keys`: A dictionary containing information about LUKS keys.
  - `luks_key_size`: The size of the LUKS key (in bits) to be generated.
  - `luks_containers`: A dictionary defining LUKS containers for management.

## Variable Elements

1. `luks_keys`:
   - Type: Dictionary
   - Description: A dictionary defining LUKS keys with the following attributes for each key:
     - `name`: Human-friendly name for the LUKS key.
     - `description`: A description of the LUKS key.
     - `keyslot`: The key slot on the LUKS device.
     - `key_vault_id`: An identifier for the key in the vault (if applicable).
     - `key_file_name`: The name of the file containing the LUKS key.

2. `luks_key_size`:
   - Type: Integer
   - Description: The size of the LUKS key to be generated, specified in bits.

3. `luks_containers`:
   - Type: Dictionary
   - Description: A dictionary defining LUKS containers with the following attributes for each container:
     - `name`: Human-friendly name for the LUKS container.
     - `path`: The path to the device associated with the LUKS container.
     - `key_file`: The LUKS key associated with the container.

## Example Playbook

```yaml
---
- name: LUKS Key and Container Management
  hosts: localhost
  gather_facts: true
  become: true
  tasks:
    - name: Manage LUKS Keys and Containers
      include_role:
        name: luks_key_management
```

## Tasks Explanation

1. **Manage LUKS Keys and Containers:**
   - Invokes the LUKS Key Management role, performing tasks such as generating, adding, and managing LUKS keys, as well as creating, opening, and closing LUKS containers based on the provided configurations.

## Usage

1. Include the LUKS Key Management role in your playbook.
2. Set the required variables in the playbook or use external variable files.
3. Run the playbook to manage LUKS keys and containers based on the provided configurations.

## Note

This role assumes that the target system has LUKS-enabled devices. Ensure that the required packages and dependencies are installed before executing this role. Customize the `luks_keys` and `luks_containers` variables according to your specific LUKS key and container management requirements.

## Recommendations

It is recommended to store LUKS keys securely, considering the sensitivity of encryption keys. Utilize vaults or secure storage mechanisms to protect LUKS keys from unauthorized access.

## License

This role is released under the [MIT License](LICENSE). Feel free to contribute or report issues on the [GitHub repository](https://github.com/SuperPanda/orchestration-architect-ansible).

