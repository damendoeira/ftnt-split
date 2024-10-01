#!/bin/bash

B="$1"

#grep -Ee ^config "$1"
#echo ###
mkdir -p "${B%.conf}"

grep -Ee ^config "$B" | grep -vEe "^config vdom$" | sed "s/^config //" | while read A ; do
  echo -ne "\033[2K\r"
  echo -n "$A"
  TARGET="${B%.conf}"/"${B%.conf}"-"${A// /-}"
  sed -n "/^config ${A}$/,/^end/p" "$B" > "${TARGET}".conf
  LINECOUNT=$(wc -l "${TARGET}".conf | cut -f1 -d" ")
  mv "${TARGET}".conf "${TARGET}"-${LINECOUNT}.conf
done

echo -ne "\033[2K\r"
