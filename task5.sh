#!/bin/bash

stepCount=1
hitCount=0
missCount=0
numbers=()

while true; do
    randomNum=$(( RANDOM % 10 ))

    echo "Step: $stepCount"
    read -rp "Please enter a number from 0 to 9 (q to quit): " input

    if [[ $input == "q" ]]; then
        break
    fi

    if ! [[ $input =~ ^[0-9]$ ]]; then
        echo "Invalid input. Please try again."
        continue
    fi

    if [[ $input -eq $randomNum ]]; then
        echo "Hit! My number: $randomNum"
        (( hitCount++ ))
        numbers+=("$(tput setaf 2)$randomNum$(tput sgr0)")
    else
        echo "Miss! My number: $randomNum"
        (( missCount++ ))
        numbers+=("$(tput setaf 1)$randomNum$(tput sgr0)")
    fi

    hitPercentage=$(( (hitCount * 100) / (hitCount + missCount) ))
    missPercentage=$(( 100 - hitPercentage ))

    echo "Hit: $hitPercentage%  Miss: $missPercentage%"
    echo "Recent Numbers: ${numbers[@]: -10}"
    echo

    (( stepCount++ ))
done
