#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Update Source Server
if [ ! -z ${BETA} ]; then
    if [ ! -z ${SRCDS_APPID} ]; then
        if [ ! -z ${BETA_PW} ]; then
            ./steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir /home/container +app_update ${SRCDS_APPID} -beta ${BETA} -betapassword ${BETA_PW} +quit            
        else
            ./steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir /home/container +app_update ${SRCDS_APPID} -beta ${BETA} +quit
        fi
    fi
else
    if [ ! -z ${SRCDS_APPID} ]; then
        ./steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir /home/container +app_update ${SRCDS_APPID} +quit
    fi
fi
    
# Set up wine environment
wineboot
winetricks sound=disabled

# Spawn a virtual frame buffer - Replace with xvfb-run
Xvfb :0 -screen 0 1024x768x16 -ac &
DISPLAY=:0

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
