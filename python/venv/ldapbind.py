#!/usr/bin/python

from paramiko import SSHClient
import paramiko

class SSH:
    def __init__(self):
        self.ssh = SSHClient()
        self.ssh.load_system_host_keys()
        self.ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        self.ssh.connect(hostname='192.168.8.100', username='admin', password='o2ipa@dmin')

usuario = int()
novasenha = int()

    def exec_cmd(self, cmd):
        stdin, stdout, stderr = self.ssh.exec_command()
        if stderr.channel.recv_exit_status() != 0:
            print
            stderr.read()
        else:
            print
            stdout.read()
