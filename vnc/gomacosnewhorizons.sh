#!/bin/sh

# Screen sharing enabled via settings.
# Custom firewall rules enabled via /etc/pf.conf (man pf.conf), allowing only localhost:5900

# SSH Tunnel:
# ssh -NTL 5903:localhost:5900 io@newhorizons

#vncviewer localhost:5903 -AlwaysCursor -CursorType=System -CompressLevel=9 -QualityLevel=0 -FullScreen -FullScreenMode=All -LowColorLevel=0  # newhorizons macOS
vncviewer localhost:5903 -AlwaysCursor -CursorType=System -FullScreen -FullScreenMode=All # newhorizons macOS
