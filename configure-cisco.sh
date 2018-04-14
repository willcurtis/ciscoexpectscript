#!/bin/bash
 # Collect the current user's ssh and enable passwords
 echo -n "Enter the SSH password for $(whoami) "
 read -s -e password
 echo -ne '\n'
 echo -n "Enter the Enable password for $(whoami) "
 read -s -e enable
 echo -ne '\n'
# Feed the expect script a device list & the collected passwords
for device in `cat device-list.txt`; do
 ./configure-cisco.exp $device $password $enable ;
 done

# Logfile Rotation
timestamp=`date +%d-%m-%H%M`
logdir=<log file location here>

# This will rotate and append date stamp...
logfile=$logdir/results.log
newlogfile=$logfile.$timestamp
mv $logfile $newlogfile

# Send log notification to Slack
logmessage=results.log.$timestamp
jarjar -e -m "Hey $(whoami), Looks like your script has finished, grab a :beer: and go check: $logmessage"
