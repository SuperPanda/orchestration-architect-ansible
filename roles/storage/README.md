# Storage Role

## Overview

The `storage` role is a versatile component in Ansible that manages storage configurations across various scenarios. It supports plain filesystem paths, LUKS-encrypted volumes, and BTRFS subvolumes, allowing you to define a comprehensive storage setup in a structured and coherent way.

## Configuration Parameters

The role can be configured with the following parameters:

- `name`: A human-readable identifier for the storage.
- `path`: The file system path or device label for the storage.
- `luks` (optional): A dictionary specifying the LUKS configuration:
  - `keyfile`: The file path to the key used for LUKS encryption.
  - `device_name`: The name used by the device mapper for the LUKS volume.
- `btrfs_subvolumes` (optional): A list of dictionaries specifying BTRFS subvolumes configurations:
  - `name`: The name of the BTRFS subvolume.
  - `path`: The path where the subvolume will be mounted or located.
  - `description`: A human-readable description of the subvolume's intended use.

## Role Behavior

- **State Management**: The `storage` role uses the `state` variable to determine the operation to perform. The possible states are `present`, `absent`, and `info`.
- **LUKS Integration**: When LUKS configuration is provided, the role interacts with the `luks` role to manage encryption states and volume accessibility.
- **BTRFS Integration**: When BTRFS subvolumes are defined, the role coordinates with the `btrfs_subvolumes` role to manage the subvolumes based on the LUKS state.

## Example Playbook

The following playbook demonstrates how to use the `storage` role to gather information about a BTRFS volume setup on an external drive that is encrypted with LUKS:

```yaml
---
- name: Gather info about the external backup drive storage
  hosts: localhost
  connection: local
  gather_facts: true
  roles:
    - role: common
      ansible_root: "{{ playbook_dir | dirname }}"
    - role: storage
      state: info
      storage:
        name: "External Backup Drive"
        path: /dev/disk/by-label/external-backup
        luks:
          keyfile: /root/keyfiles/external-backup.key
          device_name: external-backup
        btrfs_subvolumes:
          - name: "@external_backups"
            path: "@external-backups"
            description: "The top level subvolume for external backup subvolumes."
          - name: "@external_backups_nextcloud"
            path: "@external-backups/nextcloud"
            description: "The subvolume to store nextcloud backups on an external drive."
          - name: "@external_backups_windows"
            path: "@external-backups/windows"
            description: "The subvolume to store the backups of windows-based systems."
          - name: "@external_backups_linux"
            path: "@external-backups/linux"
            description: "The subvolume to store the backups of linux-based systems."
```

## Design Philosophy

The `storage` role adopts a categorical design philosophy, where:

- **Objects** represent storage configurations.
- **Morphisms** are the actions taken to transition between states.
- **Functors** describe the interaction between the storage role and the `luks` or `btrfs_subvolumes` roles, mapping the base storage configuration to an encrypted or subvolume-based state.

## Design Considerations

To model the state and behaviour of the storagecomponents categorically, we'll define our objects, morphisms, and functors to represent the state and behavior of the system. Let's break it down:

### Objects

- **Storage Path**: Represents the file path to the storage volume.
- **LUKS Device**: Represents the LUKS-encrypted volume, which can be in a "locked" or "unlocked" state.
- **BTRFS Volume**: Represents the BTRFS filesystem, which can reside directly on a storage path or on a LUKS device.

### Morphisms

- **Check**: An action to verify if the LUKS device is unlocked.
- **Map**: Transforms a storage path based on the state of the LUKS device, potentially mapping it to `/dev/mapper/{{ luks.device_name }}` if unlocked.

### Functors

- **LUKS Functor**: Takes the storage path and returns a mapped path if the LUKS device is unlocked.
- **BTRFS Functor**: Takes the result of the LUKS Functor and applies BTRFS operations such as listing subvolumes.

### Natural Transformations

- **Mount/Unmount**: Changes the mount state of the BTRFS volume.
- **Lock/Unlock**: Changes the state of the LUKS device.

Now, let's structure the roles and their interactions using these categorical concepts:

1. **Storage Role**:

   - Define a storage object that includes the path and optional LUKS configuration.
   - This object is the starting point for our model.

2. **LUKS Role**:

   - If LUKS configuration is present, apply the LUKS Functor to map the storage path to the LUKS device path.
   - This functor is only active if the LUKS device is unlocked, representing a morphism from "locked" to "unlocked".

3. **BTRFS Role**:

   - Apply the BTRFS Functor to perform operations on the BTRFS volume.
   - The BTRFS Functor takes the output of the LUKS Functor (the mapped path) and performs BTRFS-specific operations.

4. **Ansible Tasks**:
   - For the LUKS role, check the status of the LUKS device and register whether it's unlocked.
   - For the BTRFS role, conditionally include tasks based on the status of the LUKS device.

Here is an example of how you might represent these relationships in Ansible code:

```yaml
# In the storage role's tasks:

- name: Determine the final storage path
  set_fact:
    final_storage_path: "{{ (storage.luks and luks_unlocked) | ternary('/dev/mapper/' + storage.luks.device_name, storage.path) }}"
```

```yaml
# In the BTRFS role's tasks:

- name: Check if BTRFS volume is accessible
  ansible.builtin.stat:
    path: "{{ final_storage_path }}"
  register: btrfs_volume_accessible

- name: Proceed with BTRFS operations if volume is accessible
  when: btrfs_volume_accessible.stat.exists
  block:
    # BTRFS operations here...
```

The `final_storage_path` fact represents the result of applying the LUKS Functor. If LUKS is configured and the device is unlocked, the path will be mapped to the device mapper; otherwise, it will remain the physical storage path.

This categorical approach allows you to abstract the complexity of the underlying storage system and to create a flexible, extensible model where the behavior of the system can be changed by modifying the morphisms (actions) without altering the objects themselves.
