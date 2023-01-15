source common.sh 
LOG=/tmp/roboshop.log
set_location=$(pwd)

print_head "curl on process"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
condition_check

print_head "install nodes js"
yum install nodejs -y
condition_check

print_head "checking and adding add user"
id roboshop &>>${LOG}
if [ $? -ne 0 ]; then
 useradd roboshop &>>${LOG}
fi
condition_check
print_head "hi helow"
print_head " making the directory app"
mkdir -p /app 
condition_check

print_head "curl on process"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
condition_check

print_head " removing the existing files"
rm -rf /app/*
condition_check

print_head "changing the directory"
cd /app 
condition_check

print_head "unzipping the files "
unzip /tmp/catalogue.zip
condition_check

print_head "chaging the directory"
cd /app 
condition_check

print_head "installing the npm"
npm install 
condition_check

print_head "copying the files to location etc"
cp ${set_location}/files/catalogue.service /etc/systemd/system/catalogue.service
condition_check

print_head "daemon reload "
systemctl daemon-reload
condition_check

print_head " enabling the catalogue"
systemctl enable catalogue 
condition_check

print_head "strating the catalogue"
systemctl start catalogue
condition_check

print_head "copying the files to location etc"
cp ${set_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo
condition_check

print_head "inastalling the mongod to shell"
yum install mongodb-org-shell -y
condition_check

print_head "hosting the ip mongodb"
mongo --host 172.31.87.242 </app/schema/catalogue.js
condition_check

print_head "restarting the catalogue"
systemctl restart catalogue
condition_check