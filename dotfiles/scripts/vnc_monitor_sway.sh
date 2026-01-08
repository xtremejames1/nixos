#!/usr/bin/env bash

# Get the laptop's current IP address automatically
local_ip=xtremelaptop3b.local
echo "Local IP: $local_ip"

chromebook_ip=$(getent hosts jxchromenix.local | awk '{print $1}')
if [ -n "$chromebook_ip" ]; then
  echo "Found chromebook at: $chromebook_ip"
else
  echo "Could not find jxchromenix.local"
  exit 1
fi


swaymsg create_output HEADLESS-1
echo "Created output"
sleep 1
output=$(swaymsg -t get_outputs | rg "(HEADLESS-.+)\"" -or '$1')

file="./xtremelaptop3b.remmina"
cat <<EOM >$file
[remmina]
encodings=
username=xtremejames1
name=laptop
ssh_tunnel_auth=0
ssh_tunnel_privatekey=
password=
window_maximize=0
quality=2
disablesmoothscrolling=0
precommand=
ssh_tunnel_enabled=0
labels=
ssh_tunnel_command=
viewonly=1
ignore-tls-errors=1
aspect_ratio=
postcommand=ssh xtremejames1@$local_ip 'tmux send-keys -t wayvnc "swaymsg output $output unplug" Enter && sleep 1 && tmux send-keys -t wayvnc "pkill wayvnc" Enter && tmux kill-session -t wayvnc'
closeonfailure=0
server=$local_ip
disablepasswordstoring=0
tightencoding=0
ssh_tunnel_username=xtremejames1
disconnect-prompt=0
disableclipboard=0
disableserverbell=0
ssh_tunnel_password=
profile-lock=0
disableserverinput=0
viewmode=4
group=
window_height=701
enable-autostart=0
ssh_tunnel_loopback=0
notes_text=
ssh_tunnel_server=
window_width=1362
ssh_tunnel_certfile=
keymap=
disableencryption=0
proxy=
protocol=VNC
ssh_tunnel_passphrase=
showcursor=0
colordepth=32
EOM

echo "Created .remmina file"
echo "Output: $output"
swaymsg output "$output" mode 1366x768
echo "Set resolution"
tmux new-session -d -s "wayvnc"
tmux send-keys -t wayvnc "wayvnc 0.0.0.0 --output=\"$output\" &" Enter
echo "Initialized WayVNC, waiting 2 seconds..."
sleep 2
echo "Connecting to target computer"
if sftp xtremejames1@$chromebook_ip:/home/xtremejames1/.remmina <<EOF
put $file xtremelaptop3b.remmina
exit
EOF
then
  echo "Sent remmina script to target computer"
  sleep 2
  ssh xtremejames1@$chromebook_ip 'DISPLAY=:0 nohup remmina -c ~/.remmina/xtremelaptop3b.remmina > /dev/null 2>&1 &'
  echo "Established Connection"
else
  echo "failed to transfer remmina file"
  exit 1
fi
