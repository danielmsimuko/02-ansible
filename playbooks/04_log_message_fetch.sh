#!/bin/bash

# for each remote server in hosts, compresses /var/log/messages with tar on a remote server
# and store it in /tmp/messages.tar.gz
# /etc/ansible/hosts file must contain correct hostnames

 for i in WebServer1 DBServer1 AdminServer1;
 do ssh ansible@Si "sudo tar -czf messages.tar.gz /var/log/messages";
 done

# copy will take file from host and put it on remote server
# fetch will take file from remote server and add it to host

ansible -m fetch -a "/home/ansible/messages.tar.gz dest=/tmp/messages" all
