# Cisco Expect Script
Expect Script for bulk configuration of Cisco Routers / Switches

Based on Paul Gerard Porter's post and script for bulk configuration of Cisco routers and switches - https://paulgporter.net/2012/12/08/30/

In additional to the 2 files here, you will need a file called device-list.txt containing a list of device IPs or hostnames (one per line) that you want to configure.

The devices in the list are passed one at a time with the password and enable password to the Expect script (configure-cisco.exp)

The expect script contains a section at the bottom where you can build the commands required to configure the equipment, for example:

Enter your commands here.
send "Some Command here\n"
expect "(config)#"
send "some other command here\n"
expect "(config)#"

I have found it best to manually configure one device first and make note of the change in prompt depending on the command entered, this way it is easier to build the script if you know what to expect (no pun intended)

Once you are happy with your commands and device list simply fire up ./configure-cisco.sh and follow the prompts to enter the user password and enable password (the scripts assumes the username is the user logged in to the system you are running the script from, in my case my TACACS username matches my laptop login) the script will then run and pass the passwords and the device to the expect script.

This script will only use a static list of commands, if you wish to pass variables in to the commnd list there are a couple of changes requried to the script. 
