#!/bin/bash
aws ec2 describe-instances | grep PrivateIpAddress | grep -o -P "\d+\.\d+\.\d+\.\d+" | grep -v '^10\.' | tail -1 >> /etc/ansible/hosts
	 
	 
