#Name:Naveen ps
#Date:12Aug,2024
#Project:LS Project (Quiz) (command line test)


#!bin/bash

function exam()
{

                    answer=(`cat answer.txt`)                       #add data of answer.csv file in an array "answer"
                    marks=0
                    x=0
                    for i in `seq 5 5 25`                           #run for loop with increment of 5 from 5 to 25 (no. of lines in question.txt are 25)
                    do
                      head -$i question.txt | tail -5               #print five lines at a time from question.txt and next time when loop runs print next 5 lines
                      for j in `seq 10 -1 1`                        #run for loop from 10 to 1
                      do
                         echo -n -e "\rEnter the option: $j \c"     #print this statement
                         read -t 1 option                           #read the option entered while delaying loop with 1se every time for value of $j
                         if [ -n "$option" ]                        #check if user entered the option or not
                         then
                             break                                  #stop the loop for timer
                         fi
                      done
                    if [ -z "$option" ]                             #to check is variable is empty i.e. no option entered
                    then
                         option="e"                                 #store 'e' to variable "option"
                         echo "Timeout"
                    fi
                    if [ $option = ${answer[$x]} ]                  #check if the entere option and correct answer matches or not
                    then
                         echo
                         echo "User answer    : $option"            #print user entered answer
                         echo "Correct answer : ${answer[$x]}"      #print the correct answer
                         echo -e "\e[0;32m <<CORRECT>> \e[0m"       #if ans matches then print this ststement in green colour
                         marks=$((marks+20))                        #increment the marks by 20
                    else
                         echo
                         echo "User answer    : $option"            #print user entered answer
                         echo "Correct answer : ${answer[$x]}"      #print the correct answer
                         echo -e "\e[0;31m <<INCORRECT>> \e[0m"     #if not matches then print this statement in red colour
                    fi
                    echo
                    x=$((x+1))
                    option=""
                    done
                    echo "Total Marks obtained = $marks%"           #show total marks obtained by user
                    echo
                    read -p "Do you want to take test again y/n: " attempt #ask user if he want to give exem again
                    echo
                    flag2=1
}

function sign_up()
{

                   echo "$usv" >> user.csv                                                      #if user name does not exists then add it to user.csv file
                   flag=$count
                    while [ $flag -eq 0 ]
                    do
                         flag=1
                         echo "Enter the password: "                                            
                         read -s ps1                                                            #read the password
                         echo "Enter the confirmation Password: "
                         read -s ps2                                                            #read the confirmation password
                         echo
                         if [ $ps1 = $ps2 ]                                                     #if both password matches then add it to password.csv file
                         then
                            echo "$ps1" >> password.csv                                         #add password to password.csv file
                            echo "Sign Up is successful"
                            echo "Sign in to proceed for test"
                            echo
                            attempt=y                                                           #again provide opetion to perform operation to user
                         else
                             echo "Error://Password didn't match, please enter again"           #if password dosent match then print this error
                             flag=0
                         fi
                    done
}

function sign_in()
{

        while [ $flag1 -eq 0 ]
        do
          flag2=0
          read -p "Enter the username: " usv1                       #read the username
          echo "Enter the password: "
          read -s ps3                                               #read the password
          length=$((${#user[@]}-1))
          for i in `seq 0  $length`                                 #run the loop for every index no. of array "user"
          do
            if [ $usv1 = ${user[$i]} ]                              #check if entered username and available is match or not
            then
                position=$i
                if [ $ps3 = ${pass[$position]} ]                    #if user name matched then check password for that username matches or not
                then
                    flag1=1
                    echo "Sign in is successful."                   #if username and password matches then proceed to test
                    echo
                    exam                                            #call exam function
                    break
                else
                    echo "Error://Password is incorrect"
                    flag2=1
                    break
                fi
            fi     
          done
              if [ $flag2 -eq 0 ]                                   #if username does not matches then print this error message
              then
                  echo "Error://Username does not exist. Please Create account or check the Username"
              fi
        done
}

attempt=y
while [ $attempt = y ]
do
    attempt=n
    echo "Select a number to perform operation 
1.Sign Up
2.Sign in
3.Exit" 
    read op                                                                                     #read the option entered by user
case $op in                                                                                     #perforn operation according to the user choice
    1) 
       arr=(`cat user.csv`)                                                                     #enter user.csv date in an array
       count=1
       while [ $count -eq 1 ]
       do
            count=0
            read -p "Enter the username: " usv                                                  #read the username 
            for i in ${arr[@]}                                                                  #run for loop for every element of usernames in an array
            do
                if [ $i = $usv ]                                                                #check if username exists or not
                then
                    count=1
                    echo "Error://Username already exist. Please use another username"          #if exists then print this error message
                fi
            done
                if [ $count -eq 0 ]
                then
                    sign_up                                                                     #call function sign_up
                fi
       done
       ;;
    2)
        user=(`cat user.csv`)                                       #add data of user.csv file in an array "user"
        pass=(`cat password.csv`)                                   #add data of password.csv file in an array "pass"
        flag1=0
        sign_in
        ;;
    3)
        echo
        echo "<<--Thank You-->>"
        ;;
    *)
        echo "Please enter valid option"
        attempt=y
        echo
        ;;
 esac
done
