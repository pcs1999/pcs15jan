print_head() {
  echo -e "\e[33m $1 \e[0m"
}

condition_check() {
    if [ $? -eq 0 ]
then
 echo success
else 
 echo failure
fi
}