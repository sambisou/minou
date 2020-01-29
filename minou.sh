#!/bin/bash

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

NC='\033[0m' # No Color
BOLDRED='\033[0;31m\e[1m' 
BOLD='\e[1m' 
#GREEN='\033[1;32m'
GREEN='\e[32m'
BOLDGREEN='\033[1;32m\e[1m'

echo -e "No style"
echo -e "${BOLD}Bold${NC}"
echo -e "${BOLDRED}Bold & Red${NC}"
echo -e "${GREEN}Green${NC}"
echo -e "${BOLDGREEN}Bold & Green${NC}"

############### OBJECT DEFINITION ###################

# to_compile object 
# => to_compile[0]="<lib-name-to-be-compiled>"
# => to_compile[1]=1 if must compile, 0 


to_compile=("application-database" "application-bacsauter" "application-alien-bus-connector-daemon" "lib-dali-ct" "dali-grunt")
selected=()
cursor_index=0;

for item in ${to_compile[@]}; do
echo $item
selected=(1 1 1 1)
done



UPLINE=$(tput cuu1)
ERASELINE=$(tput el)

IFS=''
SELECT=""
#while [[ "$SELECT" != $'\x0a' && "$SELECT" != $'\x20' ]]; do

# if no config file found : enable all items to be compiled
for i in "${!to_compile[@]}"
   do : 
   selected[$i]=1
done

while true; do
tput clear
    echo -e "#######################\n#   Ninja Build CLI   #\n#######################"
    echo -e "Move and select using ${BOLD}<UP>${NC} or ${BOLD}<DOWN>${NC} arrows and ${BOLD}<SPACE>${NC} to enable or disable compilation. ${BOLD}<ENTER>${NC} to launch."
    echo -e "Press ${BOLD}<Enter>${NC} to launch or ${BOLD}<Space>${NC} to de/select\n"

   for i in "${!to_compile[@]}"
   do : 
      if [[ $i == $cursor_index ]]; then #BOLD
         if [[ ${selected[$i]} == "1" ]]; then #GREEN
            echo -e "${BOLDGREEN}[X] : ${to_compile[$i]}${NC}"
         else # just BOLD
         echo -e "${BOLD}[ ] : ${to_compile[$i]}${NC}"
         fi
      else # not BOLD
         if [[ ${selected[$i]} == "1" ]]; then #GREEN
            echo -e "${GREEN}[X] : ${to_compile[$i]}${NC}"
         else # not BOLD nor Green
         echo -e "[ ] : ${to_compile[$i]}${NC}"
         fi
      fi
       
   done
   echo -e "\nPress ${BOLD}<Enter>${NC} to start build"

   read -s -N 1  SELECT

# print array : it is updated everytime a key is hit
# A is up, B is down

#echo "key stroke: ${SELECT}"

#print all options
#tput clear



        if [[ "$SELECT" = $'A' ]]; then # key UP
                if [[ "$cursor_index" -gt "0" ]]; then
                   ((cursor_index--))
                fi
        fi

        if [[ "$SELECT" = $'B' ]]; then # key DOWN
      if [[ "$cursor_index" -lt ${#to_compile[@]}-1 ]]; then
         ((cursor_index++))
      fi 
        fi

   if [[ "$SELECT" = $'\x0a' ]]; then # pressed ENTER
     printf "\n${BOLD}pressed enter\nokidoki\033[A\033[A"
     printf "${BOLD}BOLD\033[A"
   fi

   if [[ "$SELECT" = $'\x20' ]]; then # pressed SPACE
     if [[ ${selected[$cursor_index]} == "1" ]]; then
      selected[$cursor_index]=0
     else
      selected[$cursor_index]=1
     fi
   fi


done