source common.sh
set_patch=$(pwd)

print_head "curl on process"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
condition_check

print_head "installing the node js"
yum install nodejs -y
condition_check

print_head "adding the user"
#useradd roboshop
condition_check

print_head "making the directory"
mkdir -p /app 
condition_check

print_head "curl on process"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
condition_check

print_head "changing the directory to app"
cd /app 
condition_check

print_head "unzipping the files"
unzip /tmp/user.zip
condition_check

print_head "changing the directory to app"
cd /app 
condition_check

print_head "installing the npm"
npm install 
condition_check

print_head "copying the files to etc"
cp ${set_path}/files/user.service /etc/systemd/system/user.service
condition_check

print_head "reloading the daemon"
systemctl daemon-reload
condition_check

print_head "enabling the user"
systemctl enable user 
condition_check

print_head "starting the user"
systemctl start user
condition_check

print_head "copying the files to etc "
cp ${set_patch}/files/mongo.repo /etc/yum.repos.d/mongo.repo
condition_check

print_head "installing the mongodb"
yum install mongodb-org-shell -y
condition_check

print_head "hosting the ip mongoserver"
mongo --host 172.31.87.242 </app/schema/user.js
condition_check

systemctl restart