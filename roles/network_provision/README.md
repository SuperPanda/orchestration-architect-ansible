# Network Provision Role

## Overview

The Network Provision role focuses on the configuration of network elements using OpenvSwitch within an Arch Linux environment. It plays a crucial role in defining and setting up bridges, ports, and VLANs based on the provided configurations. This role is designed to be a modular and scalable solution for managing network configurations efficiently.

## Configuration

- **Variables:**
  - `bridges`: A dictionary defining the network bridges, their names, and types.
  - `ovs_ports`: A dictionary specifying the OpenvSwitch ports and their corresponding tap interfaces.
  
## Variable Elements

1. `bridges`:
   - Type: Dictionary
   - Description: A dictionary defining network bridges with the following attributes for each bridge:
     - `bridge_name`: Name of the bridge.
     - `bridge_type`: Type of the bridge, e.g., 'ovs'.
     - `vlans`: A list of VLAN configurations for the bridge.

2. `ovs_ports`:
   - Type: Dictionary
   - Description: A dictionary specifying the OpenvSwitch ports with the following attributes for each port:
     - `tap_interface`: The tap interface associated with the port.

## Example Playbook

```yaml
---
- name: Network Provisioning
  hosts: localhost
  gather_facts: true
  become: true
  tasks:
    - name: Enumerate Bridges
      set_fact:
        enumerated_bridges: "{{ bridges|dict2items }}"

    - name: Configure OpenvSwitch
      include_role:
        name: network_provision
```

## Tasks Explanation

1. **Enumerate Bridges:**
   - Collects information about bridges from the `bridges` variable and converts it into a format suitable for iteration.

2. **Configure OpenvSwitch Bridges:**
   - Creates OpenvSwitch bridges based on the provided configurations, registering the output.

3. **Print Bridge Configuration Output:**
   - Outputs the results of the bridge creation process.

4. **Configure OpenvSwitch Ports:**
   - Adds ports to the OpenvSwitch bridges, registering the output.

5. **Print Port Configuration Output:**
   - Outputs the results of the port creation process.

6. **Configure VLANs:**
   - Configures VLANs on the specified ports, registering the output.

7. **Print VLAN Configuration Output:**
   - Outputs the results of the VLAN configuration process.

## Usage

1. Include the Network Provision role in your playbook.
2. Set the required variables in the playbook or use external variable files.
3. Run the playbook to configure OpenvSwitch bridges, ports, and VLANs based on the provided configurations.

## Note

This role assumes that OpenvSwitch is installed on the target system. Ensure that the required packages are available before executing this role. Additionally, customize the `bridges` and `ovs_ports` variables according to your network setup requirements.
