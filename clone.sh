#!/bin/bash

blue='\e[1;34'
cyan='\e[1;36m'
green='\e[1;34m'
okegreen='\033[92m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'
log="log.txt"
link="repo.txt"
url="https://github.com"
     
banner(){
    clear
    echo -e "$cyan"
    echo -e "$cyan  ____ _ ___ ____ _    ____ _  _ ____ ____ "
    echo -e "$cyan  | __ |  |  |    |    |  | |\ | |___ |__/ "
    echo -e "$cyan  |__] |  |  |___ |___ |__| | \| |___ |  \ "
    echo -e "$yellow ___________________________________________"
    echo -e "$white"
}

banner
read -p " Username to Clone : " username;
echo -e ""
mkdir $username
cd $username
echo -e "$cyan [$yellow*$cyan]$white Getting Repositories ..."
curl -s $url/$username?tab=repositories | grep "/$username/" > $log
echo -e "$cyan [$yellow*$cyan]$white Cloning Repositories ..."
cat $log | grep '<a href=' | sed -n 's/.*href="\([^"]*\).*/\1/p' > $link
rm $log
echo -e ""
while read repo
do
    echo -e "$cyan   [$okegreen-$cyan]$white $repo"
    git clone $url$repo > /dev/null 2>&1
done < $link
rm -rf *.txt
echo -e ""
echo -e "$cyan [$yellow*$cyan]$white Done"
