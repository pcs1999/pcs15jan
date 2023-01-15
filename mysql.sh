set_path=$(pwd)
source common.sh

print_head "disable mysql"
dnf module disable mysql -y 
condition_check

print_head "copying the files to etc"
cp ${set_path}/files/mysql.repo /etc/yum.repos.d/mysql.repo
condition_check

print_head "installing the my sql community"
yum install mysql-community-server -y
condition_check

print_head "enable mysqld"
systemctl enable mysqld
condition_check

print_head "starting the mysqld"
systemctl start mysqld  
condition_check

print_head "setting the password"
mysql_secure_installation --set-root-pass RoboShop@1
condition_check

print_head "restarting the mysqld"
systemctl restart mysqld
condition_check