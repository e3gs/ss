#!/bin/bash


direc=`dirname $0`
function color(){
    blue="\033[0;36m"
    red="\033[0;31m"
    green="\033[0;32m"
    yellow="\033[0;33m"
    close="\033[m"
    case $1 in
        blue)
            echo -e "$blue $2 $close"
        ;;
        red)AA
            echo -e "$red $2 $close"
        ;;
        green)
            echo -e "$green $2 $close"
        ;;
        yellow)
            echo -e "$yellow $2 $close"
        ;;
        *)
            echo "Input color error!!"
        ;;
    esac
}

function copyright(){
#    echo "#####################"
    color yellow "SSH Login              ♪⸜(๑ ॑꒳ ॑๑)⸝♪✰  "
#    echo "#####################"
#    echo
}

function underline(){
    color green "-----------------------------------------"
}

function main(){

while [ True ];do


    echo -e "序号 $green|$close       主机      $green|$close 说明"
    underline
    awk 'BEGIN {FS=":"} {printf("\033[0;36m% 3s \033[m \033[0;32m|\033[m %15s \033[0;32m|\033[m %s\n",$1,$2,$6)}' $direc/*.lst
    underline
    read -p '[*] 选择主机: ' number
    pw="$direc/*.lst"
    ipaddr=$(awk -v num=$number 'BEGIN {FS=":"} {if($1 == num) {print $2}}' $pw)
    port=$(awk -v num=$number 'BEGIN {FS=":"} {if($1 == num) {print $3}}' $pw)
    username=$(awk -v num=$number 'BEGIN {FS=":"} {if($1 == num) {print $4}}' $pw)
    passwd=$(awk -v num=$number 'BEGIN {FS=":"} {if($1 == num) {print $5}}' $pw)

    case $number in
        [0-9]|[0-9][0-9]|[0-9][0-9][0-9])
            echo $passwd | grep -q ".pem$"
            RETURN=$?
            if [[ $RETURN == 0 ]];then
                ssh -i $direc/keys/$passwd $username@$ipaddr -p $port
                echo "ssh -i $direc/$passwd $username@$ipaddr -p $port"
            else
                expect -f $direc/_ssh_login.exp $ipaddr $username $passwd $port
            fi
        ;;
        "q"|"quit")
            exit
        ;;

        *)
            echo "Input error!!"
        ;;
    esac
done
}

copyright
main

