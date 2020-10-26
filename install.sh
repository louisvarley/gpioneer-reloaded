#!/bin/bash

#get script path
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd $SCRIPTPATH


#if not root user, restart script as root
if [ "$(whoami)" != "root" ]; then
	echo "Switching to root user..."
	sudo bash $SCRIPT
	exit 1
fi

#set constants
IP="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"
NONE='\033[00m'
CYAN='\033[36m'
FUSCHIA='\033[35m'
UNDERLINE='\033[4m'

echo "Running Update..."

#install dependencies
sudo apt-get update
echo
echo "Installing Dependencies..."
echo

#get pip then jinja 2.8, templates not compatible with newer versions of Jinja2
sudo apt-get -y install python-pip
sudo pip install -I Jinja2==2.8

sudo apt-get -y install python python-dev python-requests
sudo apt-get -y install sqlite3
sudo pip install flask flask-sqlalchemy flask-admin evdev
sudo pip install evdev --upgrade

#add gpioneer-reloaded.service to systemd
file1=$SCRIPTPATH"/gpioneer-reloaded.service"
cp $file1 /lib/systemd/system/
systemctl enable gpioneer-reloaded

#add gpioneer-reloaded-web.service to systemd
file1=$SCRIPTPATH"/gpioneer-reloaded-web.service"
cp $file1 /lib/systemd/system/
systemctl enable gpioneer-reloaded-web

#create Udev rule for SDL2 applications
UDEV='SUBSYSTEM=="input", ATTRS{name}=="GPioneer", ENV{ID_INPUT_KEYBOARD}="1"'
echo $UDEV > /etc/udev/rules.d/10-GPioneer.rules
#add uinput to modules if not already there
if ! grep --quiet "uinput" /etc/modules; then echo "uinput" >> /etc/modules; fi
#add evdev to modules if not already there
if ! grep --quiet "evdev" /etc/modules; then echo "evdev" >> /etc/modules; fi

# remove retrogame
file1="/etc/rc.local"
file2="/home/pi/.profile"
if grep --quiet "retrogame" $file1 $file2; then
  echo "-----------------"
  echo "retrogame utility detected..."
  echo "Disable retrogame on startup? [y/n] (this can be undone)"
  echo "-----------------"
  read USER_INPUT
  if [[ ! -z $(echo ${USER_INPUT} | grep -i y) ]]; then
    if grep --quiet "retrogame" $file1; then
      echo "disabling retrogame in $file1"
      sed -i "/retrogame/s/^#*/: #/" $file1
      #how to uncomment: sed '/retrogame/s/^#//'
    fi
	if grep --quiet "retrogame" $file2; then
      echo "disabling retrogame in $file2"
      sed -i "/retrogame/s/^#*/: #/" $file2
      #how to uncomment: sed '/retrogame/s/^#//'
    fi
  fi
fi


echo "-----------------"
echo -e "${CYAN}Would you like to run the configuration now?${NONE} [y/n]"
echo "-----------------"
read USER_INPUT

#if yes, run gpioneer config
if [[ ! -z $(echo ${USER_INPUT} | grep -i y) ]]; then
sudo python GPioneer.py -c
clear
fi
systemctl daemon-reload
systemctl start gpioneer-reloaded

echo "-------------> Setup Complete!"
echo 
echo "Type your Pi's IP address into a web browser to customize GPioneer"
echo -e "                    ${FUSCHIA}${UNDERLINE}"$IP"${NONE}"
echo
echo
echo -e "${CYAN}${UNDERLINE}/etc/rc.local has been modified to auto run GPioneer${NONE}"
echo
echo -e "${CYAN}Configure GPioneer: sudo python GPioneer.py -c"
echo "Test GPioneer     : sudo python GPioneer.py (Ctrl+C to quit)"
echo "Run GPioneer      : sudo python GPioneer.py &"
echo
echo
echo "OPTIONAL FLAGS"
echo "--combo_time	'Time in milliseconds to wait for combo buttons'"
echo "--key_repeat	'Delay in milliseconds before key repeat'"
echo "--key_delay	'Delay in milliseconds between key presses'"
echo "--pins		'Comma delimited pin numbers to watch'"
echo "--use_bcm		'use bcm numbering instead of board pin'"
echo "--debounce	'Time in milliseconds for button debounce'"
echo "--pulldown	'Use PullDown resistors instead of PullUp'"
echo "--poll_rate	'Rate to poll pins after IRQ detect'"
echo "--------------------------------------------------------------------------------"
echo "-c				'Configure GPioneer'"
echo "--configure		'Configure GPioneer'"
echo "--button_count	'Number of player buttons to configure'"
echo
