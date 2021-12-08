#CentOS8 httpd script. 
#run script with sudo

dnf install httpd
firewall-cmd --permanent --add-service=https
firewall-cmd --reload
systemctl start httpd
systemctl status httpd
