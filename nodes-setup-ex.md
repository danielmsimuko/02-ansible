# Node setup 
scenario: You have given host and nodes to setup ansible and test connection
host: 
nodes: 3 servers to setup, webserver, dbserver, adminserver 

>PS C:\Users\daniel.msimuko> ssh cloud_user@3.236.114.240
>Password:

become root 

[root@Server1 ~]# cd /etc/ansible
[root@Server1 ansible]# ls
ansible.cfg  hosts
[root@Server1 ansible]# vim hosts

edit the file to include webservers 

```
[webservers]
WebServer1

[dbservers]
DBServer1

[admins]
AdminServer1

```

[root@Server1 ~]# cd /root/.ssh/

[root@Server1 .ssh]# ls -la

total 12
drwx------. 2 root root   61 Jun  7 09:44 .
dr-xr-x---. 7 root root 4096 Jun  7 09:55 ..
-rw-------. 1 root root    0 Jun  7 09:42 authorized_keys
-rw-------. 1 root root 2602 Jun  7 09:44 id_rsa
-rw-r--r--. 1 root root  566 Jun  7 09:44 id_rsa.pub

[root@Server1 .ssh]# ssh-copy-id ansible@WebServer1

/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"

The authenticity of host 'webserver1 (10.0.0.41)' can't be established.
ECDSA key fingerprint is SHA256: 
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys

Password:

Number of key(s) added: 1

[root@Server1 .ssh]# ssh-copy-id ansible@DBServer1

/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"

The authenticity of host 'dbserver1 (10.0.0.42)' can't be established.
ECDSA key fingerprint is SHA256:
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys

Password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'ansible@DBServer1'"
and check to make sure that only the key(s) you wanted were added.

[root@Server1 .ssh]# ssh-copy-id ansible@AdminServer1

/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"

The authenticity of host 'adminserver1 (10.0.0.43)' can't be established.
ECDSA key fingerprint is SHA256:
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys

Password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'ansible@AdminServer1'"
and check to make sure that only the key(s) you wanted were added.

now try to ping the servers 

[root@Server1 .ssh]# ansible all -m ping --become

WebServer1 | FAILED! => {
    "msg": "Missing sudo password"
}
AdminServer1 | FAILED! => {
    "msg": "Missing sudo password"
}
DBServer1 | FAILED! => {
    "msg": "Missing sudo password"
}

[root@Server1 .ssh]# ssh cloud_user@WebServer1
Password:
[cloud_user@WebServer1 ~]$ sudo visudo
[sudo] password for cloud_user:
edit sudoers by giving ansible access 
exit 

[cloud_user@WebServer1 ~]$ ssh cloud_user@44.212.96.76
Password:
[cloud_user@AdminServer1 ~]$ sudo visudo
[sudo] password for cloud_user:
edit sudoers by giving ansible access

exit
logout
Connection to 44.212.96.76 closed.
[cloud_user@DBServer1 ~]$ sudo visudo
[sudo] password for cloud_user:
[cloud_user@DBServer1 ~]$ exit
logout
Connection to 34.238.193.45 closed.
[cloud_user@WebServer1 ~]$ exit
logout
Connection to webserver1 closed.

[root@Server1 .ssh]# ansible all -m ping --become
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
[root@Server1 .ssh]#
