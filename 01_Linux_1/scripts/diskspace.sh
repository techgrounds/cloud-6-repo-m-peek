#!/bin/bash

df -h --total | grep total >> /var/log/diskspace
#writes used discspace var/logs/discspace
#use logrotate for script. 