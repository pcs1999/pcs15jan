source common.sh 
LOG=/tmp/roboshop.log

set_path=$(pwd)

print_head "loading files from curl command"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
condition_check

print_head "installing node"
yum install nodejs -y &>>${LOG}
condition_check

print_head "adding user"
#useradd roboshop
condition_check

print_head " making directory"
mkdir -p /app  &>>${LOG}
condition_check

print_head " curl exceuting"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>${LOG}
condition_check

print_head "changind directory"
cd /app &>>${LOG}
condition_check

print_head " unzipping files"
unzip /tmp/cart.zip 
condition_check

print_head "change dire"
cd /app &>>${LOG}
condition_check

print_head "installing npm"
npm install &>>${LOG}
condition_check

print_head "copying cart.service "
cp ${set_path}/files/cart.service /etc/systemd/system/cart.service &>>${LOG}
condition_check

print_head "reloading"
systemctl daemon-reload &>>${LOG}
condition_check

print_head "enabling cart"
systemctl enable cart &>>${LOG}
condition_check

print_head "starting cart"
systemctl start cart &>>${LOG}
condition_check

print_head " restarting the cart"
systemctl restart cart
condition_check