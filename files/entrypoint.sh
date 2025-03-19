#!/bin/bash

# Create the log file (not strictly necessary)
touch /home/moderne/cron.log

# Runs supercronic in the background, forwarding all output to supercronic.log
/usr/local/bin/supercronic /home/moderne/crontab > supercronic.log 2>&1 &

# Run Moderne here
tail -f /dev/null
