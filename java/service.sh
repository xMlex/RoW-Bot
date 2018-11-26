#!/bin/bash
# Quick start-stop-daemon example, derived from Debian /etc/init.d/ssh
set -e

# Must be a valid filename
NAME=rules-of-war
PIDFILE=$WRAPPER_HOME/wrapper.pid
PIDFILE_W=$WRAPPER_HOME/wrapper_app.pid
#This is the command to be run, give the full pathname
DAEMON=/usr/bin/java-service-wrapper
DAEMON_OPTS="$WRAPPER_HOME/wrapper.conf wrapper.daemonize=TRUE"

export PATH="${PATH:+$PATH:}/usr/sbin:/sbin"

echo "Service $NAME path: $WRAPPER_HOME"

function start {
	start-stop-daemon --start --quiet --pidfile $PIDFILE --exec $DAEMON -- $DAEMON_OPTS
}
function stop {
	start-stop-daemon --stop --quiet --oknodo --retry 1 --pidfile $PIDFILE
	start-stop-daemon --stop --quiet --oknodo --retry 7 --pidfile $PIDFILE_W
}

case "$1" in
 start)
    echo -n "Starting daemon: "$NAME
    start
    echo "."
	;;
 stop)
    echo -n "Stopping daemon: "$NAME
    stop
    echo "."
	;;
 restart)
    echo -n "Restarting daemon: "$NAME
    stop
    start
    echo "."
    sleep 2s
	;;

  *)
  echo "Usage: "$1" {start|stop|restart}"
  exit 1
esac