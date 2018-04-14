# Cisco Expect Script
Expect Script for bulk configuration of Cisco Routers / Switches

Based on Paul Gerard Porter's post and script for bulk configuration of Cisco routers and switches with a number of modifications - https://paulgporter.net/2012/12/08/30/

In additional to the 2 files here, you will need a file called device-list.txt containing a list of device IPs or hostnames (one per line) that you want to configure.

The devices in the list are passed one at a time with the password and enable password to the Expect script (configure-cisco.exp)

The expect script contains a section at the bottom where you can build the commands required to configure the equipment, for example:

Enter your commands here.
```
send "Some Command here\n"
expect "(config)#"
send "some other command here\n"
expect "(config)#"
```

I have found it best to manually configure one device first and make note of the change in prompt depending on the command entered, this way it is easier to build the script if you know what to expect (no pun intended)

Once you are happy with your commands and device list simply fire up ./configure-cisco.sh and follow the prompts to enter the user password and enable password (the scripts assumes the username is the user logged in to the system you are running the script from, in my case my TACACS username matches my laptop login) the script will then run and pass the passwords and the device to the expect script.

This script will only use a static list of commands, if you wish to pass variables in to the commnd list there are a couple of changes requried to the script. 

1. Comment out the section in configure-cisco.sh as below:

```
# Feed the expect script a device list & the collected passwords
  #for device in 'cat device-list.txt'; do
  #./configure-cisco.exp $device $password $enable ;
  #done
```

2. Add the folling config to the script to read the device-list.txt file and a new file called variables1-list.txt

```
  # Tell the script to read the device file and the variables file
  while read -r -u3 device && read -r -u4 variable1; do

      ./configure-cisco.exp $device $password $enable $variable1
  done 3< device-list.txt 4< variables1-list.txt
```

This will pass the password, enable password, and the per device specific variable to each device to the configure-cisco.exp script. We then need to configure the configure-cisco.exp script to use the additional argument passed to it.

1. Update the following section in the configure-cisco.exp as below:

```
# Set variables
  set hostname [lindex $argv 0]
  set username $env(USER)
  set password [lindex $argv 1]
  set enablepassword [lindex $argv 2]

 # Variable1 pulled from variables1-list.txt
  set variable1 [lindex $argv 3]
```

Now you can insert *$variable1* where required in your commands to send to the router/switch, you just need to make sure that the line in the variables1-list.txt corresponds to the same line in the device-list.txt file so the correct variable is passed to the correct device.

Where required you can configure the script to read further files for additional variables e.g. variables2-list.txt and $variable2 etc.. etc..
