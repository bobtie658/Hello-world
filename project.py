# -*- coding: utf-8 -*-
"""
Created on Tue Aug  6 14:12:39 2019

@author: wcx21213
"""

# Code created for RAL computer science department
# original code was ~150 lines long, however the majority of it was cut out in order to put on github

import fabric
import paramiko

x = fabric.Connection(host="Host", user="root", port=22)

x.run("sudo useradd mydbuser", pty=True)

ssh = paramiko.SSHClient()

ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

ssh.connect('IP', username='root', key_filename='\Users\wcx21213\Downloads\key2_openSSH')

stdin, stdout, stderr = ssh.exec_command('ls')
print (stdout.readlines())
ssh.close()
