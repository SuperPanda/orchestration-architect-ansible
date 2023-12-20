## `btrfs_subvolumes` Role README

### Overview

The `btrfs_subvolumes` role is designed to manage BTRFS filesystem subvolumes on a Linux system. It can create, list, and delete BTRFS subvolumes based on the desired state specified in the playbook.

### States

This role supports multiple states that correspond to different operations:

- `present`: Ensures that the subvolumes defined in the playbook exist.
- `absent`: Ensures that the subvolumes defined in the playbook do not exist.
- `info`: Gathers and displays information about the current subvolumes on the system.

### Initial Morphism: The `info` State

When invoked with the state set to `info`, the role performs the following actions:

1. **Gather Information**: Lists all existing subvolumes on the specified BTRFS volume.
2. **Display Variables**: Outputs the configurations for any matching subvolumes as defined in the playbook or role defaults.
3. **Assertions**: Verifies that necessary variables are provided and meet the expected criteria.

### Main Routing

The `main.yml` file within the `tasks` directory acts as the router for the role. It directs the execution flow to the appropriate task file based on the `state` variable.

```yaml
# roles/btrfs_subvolumes/tasks/main.yml

- name: Route to the appropriate task file based on state
  ansible.builtin.include_tasks: "{{ state }}.yml"
```

### Configuration

To use this role, define the BTRFS subvolumes in your playbook or role `vars`:

```yaml
btrfs_subvolumes:
  - path: /path/to/mount
    subvol_name: my_subvolume
    # Additional subvolume configurations
```

### Assertions

The role includes assertions to ensure that the necessary variables are defined and correct. These assertions will halt execution if the criteria are not met, preventing potential misconfigurations.

```yaml
# roles/btrfs_subvolumes/tasks/info.yml

- name: Validate required variables
  ansible.builtin.assert:
    that:
      - btrfs_volume_path is defined
      - btrfs_subvolumes is defined
    fail_msg: "Required variables for btrfs_subvolumes info state are missing."
    success_msg: "All required variables for btrfs_subvolumes info state are present."
```

### Usage

To invoke this role, include it in your playbook with the desired state:

```yaml
- hosts: all
  roles:
    - role: btrfs_subvolumes
      state: info
      btrfs_volume_path: /path/to/btrfs/volume
      btrfs_subvolumes: "{{ my_subvolumes }}"
```

Replace `my_subvolumes` with your actual subvolume definitions.

### Conclusion

The `btrfs_subvolumes` role provides a structured and reliable way to manage BTRFS subvolumes, offering clear insights into the system's state and facilitating infrastructure as code practices for filesystem management.
