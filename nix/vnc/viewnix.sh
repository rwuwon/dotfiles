#!/bin/bash

while true; do
echo -e "\nvncviewer localhost:5905 -MenuKey=Home -FullScreen=0 #nix"
echo

echo -n "[Enter] to connect again. Any other input to exit: "
read choice
echo

case $choice in
     "")
     vncviewer localhost:5905 -MenuKey=Home -FullScreen=0 #nix
     ;;
     *)
     echo "Exited."
     break
     ;;
esac
done
