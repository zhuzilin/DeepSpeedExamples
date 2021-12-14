#!/usr/bin/env sh

#URL=http://10.1.152.99/upload/upload.php
URL=http://10.50.85.20:8080/upload/upload.php

if [ -z $1 ]; then
  echo "Usage: $0 <file-to-upload> [-p]"
  exit 1
fi
fname=$1

pack=0
if [ "$2" = "-p" ]; then
  pack=1
fi

function log() {
  msg=$1
  d=`date`
  echo "[$d] $msg"
}

function upload() {
  fname=$1
  log "Updloading $fname ..."
  curl --form uploadedfile=@$fname $URL
  echo ""
}

if [ $pack -eq 0 ]; then
  upload $fname
else
  packf=$fname.tgz
  log "Packing $fname ..."
  tar zcvf $packf $fname
  upload $packf
  rm $packf
fi

log "done"

