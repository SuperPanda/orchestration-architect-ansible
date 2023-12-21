# LUKS Role README

## Overview

The LUKS role is an integral part of the Orchestration Architect Ansible project, designed to securely manage encrypted volumes within a broader storage orchestration context. It provides mechanisms to initialize, unlock, lock, and remove LUKS encryption from block devices, ensuring data security at rest. The role operates within a framework informed by applied category theory, enhancing predictability and composability in system management.

## Theoretical Underpinnings

This role embodies category theory principles by defining system states as objects and state transitions as morphisms. The `info` state, in particular, acts as an identity morphism by reflecting the system's current configuration without inducing changes. It serves as a diagnostic tool, offering insights into whether LUKS volumes are locked or unlocked, thus informing subsequent interactions with BTRFS subvolumes.

## Expected Variables (Objects)

- `luks_name`: Descriptive name of the LUKS volume.
- `luks_path`: System path to the LUKS volume.
- `luks_keyfile`: Path to the keyfile for the LUKS volume.
- `luks_device_name`: Name used by the device mapper, typically found at `/dev/mapper/<luks_device_name>`.

## Role Behavior (Morphisms)

The role adjusts its behavior based on the `state` variable:

- `present`: Validates or initializes the LUKS volume configuration.
- `started` / `unlocked`: Unlocks the LUKS volume for access (pending implementation).
- `stopped` / `locked`: Locks the LUKS volume, securing its contents (pending implementation).
- `absent`: Removes the LUKS volume configuration (pending implementation).
- `info`: Gathers and displays information about the LUKS volume's status.

## Diagnostic `info` State

When invoked with `state: info`, the role executes tasks to:

1. Verify the presence of necessary parameters.
2. Execute a non-invasive check of the LUKS volume status.
3. Provide contextual information that can determine if the volume is locked or unlocked.

This state is critical for orchestrating interactions with BTRFS subvolumes, particularly within the storage role, as it helps decide the availability of encrypted volumes for further filesystem operations.

## Error Handling and Contextual Feedback

The role is designed to distinguish errors that indicate a locked volume from other exceptions, using them to provide detailed context. Such information is vital for the storage role to decide whether it can proceed with BTRFS operations.

## Example Playbook

```yaml
- hosts: all
  roles:
    - role: luks
      vars:
        luks_name: "secure_volume"
        luks_path: "/dev/sdx"
        luks_keyfile: "/path/to/keyfile"
        state: "info"
```

## Usage

Include this role in your playbook and set the required variables to manage LUKS volumes. The `info` state can be particularly useful for gathering current volume status, especially in preparation for filesystem operations with BTRFS.

## Documentation of Interactions

This README serves to document the `luks` role's interactions with the `storage` and `btrfs_subvolumes` roles. It highlights the role's function in providing encryption services and how its state affects the overall orchestration of storage components.

## Testing and Validation

Testing should cover various scenarios, including locked/unlocked volumes and absent parameters, to ensure the `info` state reliably reports the correct status.

## Next Development Steps

Future development will focus on implementing the `started`, `stopped`, and `absent`
