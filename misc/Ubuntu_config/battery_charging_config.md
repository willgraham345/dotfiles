Instructions on how to set up the max battery charging stuff:

Website: https://askubuntu.com/questions/34452/how-can-i-limit-battery-charging-to-80-capacity

"
I have a Asus laptop and the approach which I have found from internet is as follows. This approach may already be a part of some of the apps mentioned above but putting it here for information.

Create a service file named battery_charge_threshold.service like this.
[Unit]
Description=Set the battery charge threshold
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold'

[Install]
WantedBy=multi-user.target
Move the file to this location /etc/systemd/system
Run the following commands.
sudo chmod 644 /etc/systemd/system/battery-charge-threshold.service
sudo systemctl daemon-reload
sudo systemctl enable battery-charge-threshold.service
After doing this, charge threshold of 80% (as per service file) will persist between reboots. It will also stop charging the battery if the current level is above 80%. Hope this helps. I have been using it for almost 1.5 years without any issue.
"

