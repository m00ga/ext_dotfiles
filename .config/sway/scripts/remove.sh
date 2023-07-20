# Killall these prev processes
killall -9 swayidle
# Wait until the processes have been shut down
while pgrep -u $UID -x swayidle >/dev/null; do sleep 1; done
