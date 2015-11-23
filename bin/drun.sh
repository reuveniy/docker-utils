#!/bin/bash

filter="$1"
shift
echo Filtering $filter
docker ps | grep $filter | while read d; do
  ID="$(echo $d | cut -f 1 -d ' ')"
  echo $filter:$ID# $@
  { docker exec $ID $@ | sed -e "s/^/$filter:$ID /"; } &
done
wait
sleep 1
