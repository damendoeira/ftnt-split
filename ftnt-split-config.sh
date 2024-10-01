#!/bin/bash

B="$1"

#grep -Ee ^config "$1"
#echo ###
grep -Ee ^config "$B" | grep -vEe "^config vdom$" | sed "s/^config //" | while read A ; do
  echo "$A"
  sed -n "/^config ${A}$/,/^end/p" "$B" > ${B%.conf}-${A// /-}.conf
done
