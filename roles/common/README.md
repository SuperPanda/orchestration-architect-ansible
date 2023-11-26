# Common Role

## Overview

The Common role serves as a utility role, primarily focused on loading variables and configurations needed across different parts of the orchestrator project. It includes a task to load variables from the specified directory within the orchestrator's Ansible root.

### Configuration

- **Variables:**
  - `ansible_root`: Path to the root directory of the orchestrator's Ansible setup.

### Example Playbook

```yaml
---
- name: Common Role Usage
  hosts: localhost
  gather_facts: true
  become: true
  tasks:
    - name: Use Common Role
      include_role:
        name: common
```

## Tasks Explanation

1. **Load Vars:**
   - Includes variables from the specified directory within the Ansible root. The loaded variables are stored in the `cfg` variable.

## Usage

1. Include the Common role in your playbook.
2. Ensure that the `ansible_root` variable is set according to the path of your orchestrator's Ansible setup.
3. Run the playbook to use the Common role, loading necessary variables for other parts of the orchestrator project.

## Note

This role is designed to provide a centralized location for common variables used throughout the orchestrator project. Adjust the `ansible_root` variable if your Ansible setup is in a different directory.

## License

This role is released under the [MIT License](LICENSE). Contributions and issue reports are welcome on the [GitHub repository](https://github.com/SuperPanda/orchestration-architect-ansible).

