#!/bin/bash

NAME='mrtorrent'
TARGZ_NAME="$NAME.tar.gz"
DIR="/home/media/nodejs/$NAME"

if [ -z "$1" ]; then
  echo 'Usage: deploy HOSTNAME'
  exit 0
else
  HOSTNAME=$1
fi

USER='media'
URL="http://$HOSTNAME"
REMOTE="$USER@$HOSTNAME"

meteor build .build --server $URL

ssh $REMOTE "mkdir -p $DIR"

scp .build/$TARGZ_NAME $REMOTE:$DIR

ssh $REMOTE "cd $DIR && tar xfz $TARGZ_NAME"
ssh $REMOTE "rm -rf $DIR/bundle/programs/server/npm/npm-bcrypt"
ssh $REMOTE "cd $DIR/bundle/programs/server && npm install --production && npm install bcrypt"
ssh $REMOTE "mkdir -p $DIR/bundle/tmp $DIR/bundle/public"
ssh $REMOTE "cd $DIR && touch bundle/tmp/restart.txt"

# keytool -genkey -alias mrtorrent -keyalg RSA -keysize 2048 -validity 10000
# jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 release-unsigned.apk mrtorrent
