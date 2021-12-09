#!/bin/bash

df -h | grep root >> /var/logs/discspace
#writes used discspace var/logs/discspace
#use logrotate for script. 