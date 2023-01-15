set_patch=$(pwd)
source common.sh

print_head "installing nginx"
yum install nginx -y 
condition_check

print_head "enabling nginx"
systemctl enable nginx 
condition_check

print_head "start nginx"
systemctl start nginx 
condition_check

print_head "removing exiting files"
rm -rf /usr/share/nginx/html/* 
condition_check

print_head " curl process on "
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
condition_check

print_head " changing directory"
cd /usr/share/nginx/html 
condition_check

print_head " unzipping the content"
unzip /tmp/frontend.zip
condition_check

print_head "copying the files to robodhop.conf"
cp ${set_patch}/files/roboshop.conf   /etc/nginx/default.d/roboshop.conf 
condition_check

print_head "restarting the nginx"
systemctl restart nginx 
condition_check