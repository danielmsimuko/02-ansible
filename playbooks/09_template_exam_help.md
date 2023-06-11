
Grant users in the sysops group the ability to run all commands as root for each local system by IP address

`%sysops 34.124.22.55 = (ALL) ALL`

Define the host_alias group WEBSERVERS to contain all servers in the ansible web inventory group: 

`Host_Alias WEBSERVERS = <host name>`

Define the host_alias group DBSERVERS to contain all servers in the ansible database inventory group:

`Host_Alias DBSERVERS = <host name>`

Grant users in the httpd group the ability to sudo su - webuser on the WEBSERVERS hosts and DBSERVERS 
  
`%httpd WEBSERVERS = /bin/su - webuser` & `%dba DBSERVERS = /bin/su - dbuser`

The file must be validated using `/sbin/visudo -cf` before deployment.
