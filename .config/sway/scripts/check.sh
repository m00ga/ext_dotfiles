while true
do
    if ! pgrep -f swaylock &> /dev/null 2>&1; then
        loginctl unlock-session
        break
    else
        sleep 1
    fi
done
