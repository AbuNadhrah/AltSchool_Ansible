#!/bin/bash

#echo "what is your name?"
#read name

#echo "hi there $name"
#echo "welcome to AltSchool"

# echo "hello there" $Fname
# echo "how are you" $Aname
# echo "this is for all the variables" $@

# read -p "what is your name?"  name

# echo "hi there $name"
# echo "welcome to altschool"

# echo "Argument 1: $1"
# echo "Argument 2: $2"
# echo "Argument 3: $3"
# echo "All Arguments: $@"

#Bash Arrays
#learn and practise arrays

# my_array=(apple manago orange) #"Fruit basket"

# echo ${my_array[0]}
# echo ${my_array[@]}
# echo ${#my_array[@]}

# #Bash Slicing
# letters=(A B C D E F G)
# #slice for letter B to E
# b=${letters[@]:1:4}
# echo "${b}"

#bash Conditionals Expressions
#validate that a user inputs his name on prompt

# read -p "what is your name?" name
# if [[ -z ${name} ]]
# then
#     echo "you did not enter your name"
#     exit 1
# else
#     echo "hi there $name"
# fi

#Let us determine is the user requestin access is the Admin user
# user="dudu COM"
# read -p "What is your name" name
# if [[ ${name} == ${user} ]]
# then
#     echo "You are an Admin User"
# else
#     echo "You are not an Admin User"
# fi

#Check if user is root
# if [[ $EUID == 0 ]]
# then
#     echo "You are root"
#     exit
# else
#     echo "You are not root"
#     Exit 1
# fi

read -p "What is the name of your car? " car

case $car in
    "Tesla")
        echo "Tech boys use $car in Nigeria"
        ;;
    "Toyota" | "Honda" | "Nissan")
        echo "Suit & Tie guys use $car in Nigeria"
        ;;
    "BMW" | "Mercedes")
        echo "Yahoo boys use $car in Nigeria"
        ;;
    *)
    echo "You are on your own level using a $car"
    ;;
esac

#create directory
#create file in the directory
#put some content in the file
