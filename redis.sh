source common.sh 
set_patch=$(pwd)

print_head "installing the repo"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
condition_check

print_head "enbling the dnf module"
dnf module enable redis:remi-6.2 -y
condition_check


print_head "installing the redis"
yum install redis -y 
condition_check

print_head "changing port to 0.0.0.0"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf  /etc/redis/redis.conf
condition_check

print_head "enabling the redis"
systemctl enable redis 
condition_check

print_head "starting the redis"
systemctl start redis 
condition_check

print_head "restraing the redis"
systemctl restart redis 
condition_check
