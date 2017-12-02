#!/usr/bin/python2

import sys, pexpect

def readFile(filename):
    hostList = [[] for i in range(3)]
    file = open(filename)
    for line in file:
        parts = line.strip().split(" ")
        hostList[0].append(parts[0])
        hostList[1].append(parts[1])
        hostList[2].append(parts[2])
    return hostList

def tryLogin(hostList):
    for i in range(len(hostList)):
        connStr = "sftp " + hostList[1][i] + "@" + hostList[0][i]
        child = pexpect.spawn(connStr)
        child.expect('password:')
        child.sendline(hostList[2][i])
        child.expect('sftp>')
        child.sendline('put -p netshell.py')
        child.expect('sftp>')
        #child.sendline('exit')

filename = sys.argv[1]
hostList = readFile(filename)
tryLogin(hostList)



