# Encrypted Block Device Provision Role

## Overview

The Encrypted Block Device Provision role is designed to handle the initialization, management, and manipulation of an encrypted block device using BTRFS. It includes tasks for setting up the encrypted block device, creating snapshots, and more.

## File Structure

### Tasks

- **btrfs_init.yml:** Handles the creation of the BTRFS filesystem and necessary subvolumes.
- **crypt_init.yml:** Initiates encryption on the block device.
- **crypt_start.yml:** Opens the encrypted container for use.
- **crypt_stop.yml:** Closes the encrypted container.
- **enc_blkdev_init.yml:** Initiates the encrypted block device provisioning process.
- **enc_blkdev_remove.yml:** Removes the encrypted block device.
- **enc_blkdev_stop.yml:** Stops the encrypted block device.
- **fs_mount_stop.yml:** Manages the mounting and unmounting of filesystems.
- **loopdev_start.yml:** Opens the block device image as a loop device.
- **loopdev_stop.yml:** Closes the loop device.
- **main.yml:** The main playbook orchestrating the flow of tasks.
- **snapshot_create.yml:** Creates snapshots of the block device.
- **snapshot_rollback.yml:** Rolls back to a previous snapshot.

### Tags

Tags are used to control the flow of the role execution. The following tags are utilized:

- **always:** Tasks that are executed without being tagged explicitly.
- **init:** Tasks related to the initialization of the block device.
- **start:** Tasks for starting or initiating processes.
- **stop:** Tasks for stopping or closing processes.
- **remove:** Tasks for removing or tearing down the block device.
- **save:** Tasks related to the creation of snapshots.
- **rollback:** Tasks related to rolling back to a previous snapshot.
- **never:** Tasks that are not meant to be executed directly.

## Configuration

The role uses various variables to configure the block device provisioning. Key variables include:

- **enc_blkdev_provision_device_name:** The name of the encrypted block device.
- **enc_blkdev_provision_storage_size_mb:** The size of the storage in megabytes.
- **enc_blkdev_provison_storage_path:** The path where storage is located.
- ... (other configuration variables)

## Usage

1. Include the `enc_blkdev_provision` role in your playbook.
2. Configure the necessary variables, especially those mentioned in the "Configuration" section.
3. Execute the playbook, specifying the desired tags if needed.

```yaml
---
- name: Example Playbook Using enc_blkdev_provision
  hosts: localhost
  gather_facts: true
  become: true
  roles:
    - enc_blkdev_provision
```

To execute specific tags:

```bash
ansible-playbook -i inventory.yml playbook.yml --tags "init,start"
```

## Notes

- This role is intended for managing the lifecycle of an encrypted block device with BTRFS. Adjust configuration variables according to your requirements.
- Ensure that necessary dependencies are met, and that your Ansible setup is properly configured.

## License

This role is released under the [MIT License](LICENSE). Contributions and issue reports are welcome on the [GitHub repository](https://github.com/SuperPanda/orchestration-architect-ansible).

