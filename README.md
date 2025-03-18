## How to test?

* Clone the repo
* Run `./build.sh`

You should see the output of the `tail -f /home/moderne/cron.log` command update every minute.

## How does this work?

`cron` requires root access, which complicates things if we want to run our container using the `moderne` user. 

To work around this, we're install the superchronic utility -- a `cron` alternative that does not require root access.

In the `Dockerfile`, we:

- Use the temurin JDK image as base and install the superchronic utility
- Create the new moderne user 
- Copy the `entrypoint.sh` and `crontab` files into the container
- Set the `ENTRYPOINT` of the container to launch `entrypoint.sh`, as `moderne`
- Entrypoint runs `superchronic` as a background process and then launches `tail`, which never exits and outputs logs to stdout/stderr. 
