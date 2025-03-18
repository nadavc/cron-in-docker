#!/bin/bash

echo -- Building the Docker image
docker build . -t container-with-cron

echo -- Running the Docker image in the background
CONTAINER_ID=$(docker run -dit container-with-cron)

echo -- Tailing the log of the cronjob running in the background. Should output the date every round minute.
docker exec -it "$CONTAINER_ID" tail -F /home/moderne/cron.log
