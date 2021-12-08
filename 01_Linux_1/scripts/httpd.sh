#CentOS8 httpd script. 
#run script with sudo

dnf install httpd
#install Apache package

firewall-cmd --permanent --add-service=https
#enabling the https service port 443
firewall-cmd --reload
#reload firewall

systemctl start httpd
#start Apache process
systemctl status httpd
#verify service is running