#!/bin/bash

while true; do
echo -e "\nvncviewer 172.16.3.3:5907 -MenuKey=Home -FullScreen=0 #stardust"
echo

echo -n "[Enter] to connect again. Any other input to exit: "
read choice
echo

case $choice in
     "")
     vncviewer 172.16.7.7:5907 -MenuKey=Home -FullScreen=0 #stardust
     ;;
     *)
     echo "Exited."
     break
     ;;
esac
done
