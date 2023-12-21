#!/bin/bash

GREEN='\e[32m'
RED='\e[31m'
RESET='\e[0m'

declare -i total_guesses=1
declare -i correct_guesses=0
declare -i incorrect_guesses=0
declare -a numbers_colored

while true; do
    secret_number=${RANDOM: -1}
    echo "Ход: ${total_guesses}"

    read -rp "Пожалуйста, введите число от 0 до 9 (q - выход): " guess

    case "${guess}" in
        [0-9])
            if [[ "${guess}" == "${secret_number}" ]]
                then
                    echo -e "${GREEN}Угадано! Моё число: ${secret_number}${RESET}"
                    correct_guesses=$((correct_guesses+1))
                    secret_number_colored="${GREEN}${secret_number}${RESET}"
                else
                    echo -e "${RED}Не угадано! Моё число: ${secret_number}${RESET}"
                    incorrect_guesses=$((incorrect_guesses+1))
                    secret_number_colored="${RED}${secret_number}${RESET}"
            fi
            numbers_colored+=("${secret_number_colored}")
        ;;
        q)
            break
        ;;
        *)
            echo -e "Неверный ввод. Пожалуйста, попробуйте ещё раз.\n"
            continue
        ;;
    esac

    correct_guesses_percent=$((correct_guesses*100/(correct_guesses + incorrect_guesses)))
    incorrect_guesses_percent=$((100-correct_guesses_percent))
    echo "Угадано: ${correct_guesses_percent}%" "Не угадано: ${incorrect_guesses_percent}%"

    numbers_colored_length=${#numbers_colored[@]}
    numbers_colored_length=$(( numbers_colored_length < 10 ? numbers_colored_length : 10 ))

    echo -e "Числа: ${numbers_colored[*]: -numbers_colored_length}"
    echo -e ""

    total_guesses=$((total_guesses+1))
done
