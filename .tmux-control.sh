#! /bin/sh

while true
do
clear
echo "tmux control"
echo "1. Create new session"
echo "2. Attach to session"
echo "0. Exit"
read -p "> " choice;

case $choice in
    1)
        read -p "Enter name of session: " name
        tmux new-session -s $name
        clear; exit
    ;;
    2)
        clear
        sessions=()
        IFS=$'\n'
        declare -i counter=1
        for session in $(tmux ls -F "Session name: #{session_name} | #{session_windows} windows | Active window: #{window_name}")
        do
            echo "$counter. $session"
            IFS=' ' read -r -a elements <<< $session
            sessions+=(${elements[2]})
            counter+=1
        done
        if [[ ${#sessions[@]} == 0 ]]
        then
            echo "Session list empty"
            read -p "Press enter to continue..." > /dev/null
            clear; continue;
        fi
        echo "Enter 0 for exit"
        while true
        do
            read -p "Enter session id: " sess_choice
            if [[ $sess_choice == 0 ]] 
            then
                break
            fi
            sess_choice=$(( sess_choice - 1 ))
            if [[ " ${!sessions[*]} " == *"$sess_choice"* ]]
            then
                tmux attach -t ${sessions[$sess_choice]}
                clear; exit
            else
                echo "Wrong selection";
            fi
        done
    ;;
    0) clear; exit ;;
    *)
        echo "Wrong selection!"
        read -p "Press enter to continue..." > /dev/null
    ;;
esac
done
