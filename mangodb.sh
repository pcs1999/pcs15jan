set_patch=$(pwd)
source common.sh 

print_head "copying the files to mongo.repo"
cp ${set_patch}/files/mongo.repo  /etc/yum.repos.d/mongo.repo
condition_check

print_head "installing the mongodb"
yum install mongodb-org -y 
condition_check

print_head " enabling the mongod"
systemctl enable mongod
condition_check

print_head "starting the mongod" 
systemctl start mongod 
condition_check

print_head "changing the port to all 0.0.0.0"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
condition_check

print_head "enabling the mongod"
systemctl enable mongod 
condition_check

print_head "starting the mongod"
systemctl start mongod 
condition_check

print_head "restarting the mongod"
systemctl restart mongod
condition_check