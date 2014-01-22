#!/bin/sh
#
# add following line to /etc/rc.local
# /var/www/igakuten-app/current/run.sh start
#

APP_DIR=/var/www/igakuten-app/current
THIN_CONFIG=$APP_DIR/config/thin.yml

case $1 in
  start)
  cd $APP_DIR
  bundle exec thin start -C $THIN_CONFIG
  ;;
  stop)
  cd $APP_DIR
  bundle exec thin stop -C $THIN_CONFIG
  ;;
  restart)
  cd $APP_DIR
  bundle exec thin restart -C $THIN_CONFIG
  ;;
esac

exit 0
