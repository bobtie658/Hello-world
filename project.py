# -*- coding: utf-8 -*-
"""
Created on Tue Aug  6 14:12:39 2019

@author: wcx21213
"""

import fabric
import paramiko

x = fabric.Connection(host="172-16-114-83", user="root", port=22)

x.run("sudo useradd mydbuser", pty=True)

ssh = paramiko.SSHClient()

ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

ssh.connect('172.16.113.141', username='root', key_filename='\Users\wcx21213\Downloads\key2_openSSH')

stdin, stdout, stderr = ssh.exec_command('ls')
print (stdout.readlines())
ssh.close()
