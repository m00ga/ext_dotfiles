#! /bin/sh

filename=recording_$(date +"%Y-%m-%d_%H:%M:%S.mp4")

ret_format="{\"text\": \"\", \"percentage\": 0, \"class\": \"%s\"}"

if [ "$1" == "-i" ]
then
    printf "$ret_format" $(cat /tmp/wf-status 2>/dev/null || echo inactive) | jq --unbuffered --compact-output
    exit 0
fi


if [ -z $(pgrep wf-recorder) ];
    then 
        if [ "$1" == "-s" ]
        then geom=$(slurp 2>/dev/null || echo "exit")
            if [ "$geom" == "exit" ]
            then
                exit 1
            else
                wf-recorder -f $HOME/Recordings/$filename -g "$geom" > /dev/null 2>&1 &
                echo active > /tmp/wf-status
                notify-send "Recording started" 
	        pkill -RTMIN+8 waybar
            fi
        else
            wf-recorder -f $HOME/Recordings/$filename > /dev/null 2>&1 &
            notify-send "Recording started" 
            echo active > /tmp/wf-status
            pkill -RTMIN+8 waybar
        fi
    else
        killall -s SIGINT wf-recorder
	notify-send "Recording Complete"
    	while [ ! -z $(pgrep -x wf-recorder) ]; do wait; done
        echo inactive > /tmp/wf-status
    	pkill -RTMIN+8 waybar
fi
