#!/bin/bash

while true; do
echo -e "\nvncviewer 172.16.2.2:5902 -MenuKey=Home -FullScreen=0 #cassini"
echo

echo -n "[Enter] to connect again. Any other input to exit: "
read choice
echo

case $choice in
     "")
     vncviewer 172.16.2.2:5902 -MenuKey=Home -FullScreen=0 #cassini
     ;;
     *)
     echo "Exited."
     break
     ;;
esac
done
