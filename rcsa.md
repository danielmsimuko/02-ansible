# RedHat Certified Engineer 8 - Ansible Notes

## General Commands 

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

[//]: * (Links Section)

[Ansible Documentation]: <https://docs.ansible.com/ansible/latest/getting_started/index.html>
