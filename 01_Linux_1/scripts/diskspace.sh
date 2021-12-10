#!/bin/bash

df -h --total | grep total >> /var/logs/discspace
#writes used discspace var/logs/discspace
#use logrotate for script. 