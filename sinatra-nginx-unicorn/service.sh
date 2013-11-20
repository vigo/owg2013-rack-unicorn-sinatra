#!/usr/bin/env bash
### BEGIN INIT INFO
# Provides:          unicornd_my_unicorn_application
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the unicorn web server
# Description:       starts unicorn
### END INIT INFO

APP_NAME="my_unicorn_application"
APP_ROOT="/home/vagrant/owg2013-rack-unicorn-sinatra/sinatra-nginx-unicorn"
APP_DAEMON="unicornd_${APP_NAME}"

DAEMON_OPTS="-c ${APP_ROOT}/unicorn.rb -E production -D ${APP_ROOT}/config.ru"
PID="${APP_ROOT}/tmp/pids/unicorn.pid"
OLD_PID="$PID.oldbin"
USER="vagrant"

START_DAEMON_PROCESS="bundle exec unicorn ${DAEMON_OPTS}"
CMD="cd ${APP_ROOT}; $START_DAEMON_PROCESS;"

sig () {
  test -s "$PID" && kill -$1 `cat $PID`
}

oldsig () {
  test -s $OLD_PID && kill -$1 `cat $OLD_PID`
}

get_pid () {
  echo "`cat ${PID}`"
}

case "$1" in
start)
  sig 0 && echo >&2 "${APP_NAME} is already running $(get_pid)..." && exit 0
  echo "Starting: ${APP_NAME}"
  su - $USER -c "cd ${APP_ROOT};/home/$USER/.rbenv/shims/$START_DAEMON_PROCESS"
  sig 0 && echo >&2 "Success: ${APP_NAME} started $(get_pid)..."
  ;;

stop)
  sig QUIT && echo >&2 "Stoped: ${APP_NAME}" && exit 0
  echo >&2 "Oopps: ${APP_NAME} Not running"
  ;;

status)
  sig 0 && echo >&2 "Running: ${APP_NAME} $(get_pid)..." && exit 0
  echo >&2 "Oopps: ${APP_NAME} Not running"
  ;;

force-stop)
  sig TERM && echo >&2 "Stoped: ${APP_NAME}" && exit 0
  echo >&2 "Oopps: ${APP_NAME} Not running"
  ;;

restart|reload)
  sig HUP && echo >&2 "Reloaded: ${APP_NAME} $(get_pid)..." && exit 0
  echo >&2 "Oopps: Couldn't reload, starting '$CMD' instead."
  su - $USER -c "cd ${APP_ROOT};/home/$USER/.rbenv/shims/$START_DAEMON_PROCESS"
  ;;

upgrade)
  sig USR2 && echo >&2 "Upgrades: ${APP_NAME} $(get_pid)..." && exit 0
  echo >&2 "Oopps: Couldn't upgrade, starting '$CMD' instead"
  su - $USER -c "cd ${APP_ROOT};/home/$USER/.rbenv/shims/$START_DAEMON_PROCESS"
  ;;
  
rotate)
  sig USR1 && echo >&2 "Rotated: ${APP_NAME} logs OK..." && exit 0
  echo >&2 "Oopps: Couldn't rotate logs" && exit 1
  ;;


*)
  echo >&2 "Usage: ${APP_DAEMON} <start|stop|status|restart|upgrade|rotate|force-stop>"
  exit 1
  ;;

esac

exit 0
