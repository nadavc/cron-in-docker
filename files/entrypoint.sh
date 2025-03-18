#!/bin/bash

# Create the log file (not strictly necessary)
touch /home/moderne/cron.log

# Runs superchronic in the background, forwarding all output to superchronic.log
/usr/local/bin/supercronic /home/moderne/crontab > superchronic.log 2>&1 &

# Run Moderne here
tail -f /dev/null
