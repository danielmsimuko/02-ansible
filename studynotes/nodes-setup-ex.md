# Node setup Excercise

You have been given a host machine and three nodes to set up. Ansible is installed on host machine and nodes have been DNS'd so are named WebServer1, DBServer1 and AdminServer1.
These are the steps I followed:

1. SSH into host Server1

`# ssh cloud_user@3.236.114.240`

2. Access root

`# sudo -i`

3. Check Ansible Installation + edit hosts file 

`# vim /etc/ansible/hosts`

4. Edit the file to include nodes 

```
[webservers]
WebServer1

[dbservers]
DBServer1

[admins]
AdminServer1
```

5. Find or generate private key + save to file location

`# ssh-keygen`

6. Locate generated key and ssh-copy-id to servers. Start with WebServer1

```
`# ssh-copy-id ansible@WebServer1`
Number of key(s) added: 1
```

7. Connect to DBServer1 and continue process

```
`# ssh-copy-id ansible@DBServer1`
Number of key(s) added: 1
```

8. Connect to AdminServer1 and finish process

```
`# ssh-copy-id ansible@DAdminServer1`
Number of key(s) added: 1
```

9. Try to ping the servers and read JSON output

`# ansible all -m ping --become`

Output: 
```
WebServer1 | FAILED! => {
    "msg": "Missing sudo password"
}
AdminServer1 | FAILED! => {
    "msg": "Missing sudo password"
}
DBServer1 | FAILED! => {
    "msg": "Missing sudo password"
}
```
10. Troubleshoot by giving unrestricted access to servers via sudoers file
```
`# ssh cloud_user@WebServer1`
`$ sudo visudo
```
11. Edit file by:
```
ansible		ALL=(ALL)		NOPASSWD: ALL
```
12. Complete steps for AdminServer and DBServer1

13. Re-Run ping command to validate connection to nodes

`# ansible all -m ping --become`
14. Validate successful ping from JSON output
```
AdminServer1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
WebServer1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
DBServer1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```

# Futher study:

## Q. Imagine you now have 50 nodes. How do you distribute the ssh key to all 50 without manually logging into each one

A. Use a script to loop through all nodes and ssh-copy-id into all of them. This assumes you have the same credentials for all of the machines which is highly unlikely, so if you have different credentials, you would need to specify within the .ini file which credentials are for which machine. Alternatively you can run the script as is, and it will prompt you for the password of every machine. 

Then create this file: 
```
#!/bin/bash

# Modify the nodes array to include the hostnames or IP addresses of your nodes. You can add as many nodes as you need
nodes=(
  "node1.example.com"
  "node2.example.com"
  "node3.example.com"
  # Add more nodes here
)

# Set the ssh_key_file variable to the path of your SSH public key file.
ssh_key_file="~/.ssh/id_rsa.pub"

# Set the remote_user variable to your username on the remote nodes.
remote_user="your_username"

# Loop through the nodes and distribute the SSH key
for node in "${nodes[@]}"; do echo "Copying SSH key to $node..." ssh-copy-id -i $ssh_key_file $remote_user@$node done
```
Make the script executable then run the script and see

## Q. I now have access to 50 nodes, how can i edit the sudoers file for each of them without having to access them. 

A. This is where ansible can be extremely helpful. 

Setup the inventory file that lists the nodes you want to modify. Define the ip addresses or hostnames of nodes under a group/groups like so
````
[hosts]
node1 ansible_host=<node1_ip_address> ansible_user=<ssh_username>
node2 ansible_host=<node2_ip_address> ansible_user=<ssh_username>
...
node50 ansible_host=<node50_ip_address> ansible_user=<ssh_username>
````
Replace <nodeX_ip_address> with the actual IP address or hostname of each node, and <ssh_username> with the username you use to SSH into the nodes.

Then create a playbook that specifies the desired changes. 

```
---
- name: Modify sudoers file
  hosts: nodes
  become: true
  tasks:
    - name: Add entry to sudoers file
      lineinfile:
        path: /etc/sudoers
        line: 'names ALL=(ALL) NOPASSWD:ALL'
        validate: 'visudo -cf %s'
        
```
Customize the playbook according to the changes you want to make to the sudoers file

Execute playbook using the command.

`ansible-playbook -i inventory.ini playbook.yml --private-key=~/.ssh/your_private_key`

Replace inventory.ini with the path to your inventory file, and playbook.yml with the path to your playbook file. Also, replace your_private_key with the name of your SSH private key file.

