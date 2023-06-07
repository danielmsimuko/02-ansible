## installation

Check python Installation and verify

    1. python3 -m pip V 
    2. sudo yum install python3

Install ansible using pip
    
    3  python3 -m pip install --user ansible -- install ansible
    
If you incur an error saying: 

`Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-build-8k3oiucm/cryptography/`

The fix for the error is: 
	
    3.1 sudo python3 -m pip install -U pip   
    3.2 sudo python3 -m pip install -U setuptools

If ansible is already available on host, an upgrade is available 

    4. python3 -m pip install --upgrade --user ansible

## ad-hoc commands

`$ ansible --version` allows you to check which ansible version you currently have 

`$ sudo vim /etc/ansible/hosts` sets up the default ansible hosts file 

`$ ansible all -m ping` connects to all servers in the inventory file. You should see success

`$ ansible all --lists-hosts` shows us all the hosts in the all inventory 

`$ ansible webservers --lists-hosts` shows you the hosts within the webservers group

`ansible -m setup --tree /dir/dir localhost` generates a list of facts about the host

`ansible localhost -m copy -a "src=/tmp/facts/127.0.0.1 dest=/var/www/html/index.html mode=0600 owner=apache group=apache" --become` can then be used to copy this into a new webserver directory as file index.html

`ansible -m yum -a "name=httpd state=present" 127.0.0.1 --become` installs httpd onto localhost machine 

Output:

```
127.0.0.1 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": true,
    "msg": "",
    "rc": 0,
    "results": [
        "Installed: httpd",
        "Installed: apr-util-openssl-1.6.1-6.el8_8.1.x86_64",
        "Installed: apr-util-bdb-1.6.1-6.el8_8.1.x86_64",
        "Installed: apr-1.6.3-12.el8.x86_64",
        "Installed: apr-util-1.6.1-6.el8_8.1.x86_64",
        "Installed: httpd-2.4.37-56.module+el8.8.0+18758+b3a9c8da.6.x86_64",
        "Installed: redhat-logos-httpd-84.5-1.el8.noarch",
        "Installed: httpd-tools-2.4.37-56.module+el8.8.0+18758+b3a9c8da.6.x86_64",
        "Installed: mod_http2-1.15.7-8.module+el8.8.0+18751+b4557bca.3.x86_64",
        "Installed: httpd-filesystem-2.4.37-56.module+el8.8.0+18758+b3a9c8da.6.noarch",
        "Installed: mailcap-2.1.48-3.el8.noarch"
    ]
}

```

By default apache isnt running so we run  `ansible localhost -m service -a "name=httpd state=started enabled=yes" --become` so we can enable it

`ansible -m yum -a "name=tcpdump state=absent" localhost --become` removes tcpdump from the machine localhost or 127.0.0.1

Output:

```
127.0.0.1 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": true,
    "msg": "",
    "rc": 0,
    "results": [
        "Removed: tcpdump-14:4.9.3-3.el8.x86_64"
    ]
}
```
