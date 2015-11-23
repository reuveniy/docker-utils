#!/bin/bash

filter="$1"
ftext="$(echo $filter | sed -e 's/[\/&]/\\&/g')"
shift
echo Filtering $filter
docker ps | grep $filter | while read d; do
  ID="$(echo $d | cut -f 1 -d ' ')"
  echo $filter:$ID# $@
  { docker exec $ID $@ | sed -e "s/^/$ftext:$ID /"; } &
done
wait
sleep 1
