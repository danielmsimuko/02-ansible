## Node setup Excercise

You have given a host machine and three nodes to set up and test connection. webserver, dbserver, adminserver and control called server1.

1. SSH into Server1

`# ssh cloud_user@3.236.114.240`

2. Access root

`# sudo -i`

3. Check ansible installation + edit hosts file 

`# vim /etc/ansible/hosts`

4. Edit the file to include webservers 

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

9. Try to ping the servers

`# ansible all -m ping --become`

Read JSON output

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
