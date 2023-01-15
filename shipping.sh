source common.sh
set_path=$(pwd)

print_head "installing maven"
yum install maven -y
condition_check


print_head "adding user"
useradd roboshop
condition_check

print_head "adding app directory"
mkdir /app
condition_check

print_head "curl on process"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
condition_check

print_head "cd app"
cd /app
condition_check

print_head "unzipping "
unzip /tmp/shipping.zip
condition_check

print_head "cd app"
cd /app
condition_check

print_head "mvn clean"
mvn clean package
condition_check

print_head "mv target"
mv target/shipping-1.0.jar shipping.jar
condition_check

print_head "cp path"
cp ${set_path}/files/shipping.service  /etc/systemd/system/shipping.service
condition_check

print_head"reload"
systemctl daemon-reload
condition_check

print_head "enable"
systemctl enable shipping
condition_check

print_head "start shipping"
systemctl start shipping
condition_check

print_head "labauto"
labauto mysql-client
condition_check

print_head "hosting"
mysql -h 172.31.80.238 -uroot -pRoboShop@1 < /app/schema/shipping.sql
condition_check

print_head "restart shipping"
systemctl restart shipping
condition_check

condition_check