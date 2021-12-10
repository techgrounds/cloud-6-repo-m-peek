#!/bin/bash

df -h --total | grep total >> /var/logs/diskspace
#writes used discspace var/logs/discspace
#use logrotate for script. 