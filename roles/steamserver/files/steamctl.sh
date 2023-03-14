#!/bin/bash

steam="steamcmd"
login="+login anonymous"

mode="$1"
game="$2"
add="$3"

insdir="~/servers/${game}_ds"

declare -A appids
appids["reflex"]="329740"
appids["insurgency"]="237410"
appids["csgo"]="740"
appids["avorion"]="565060"
appids["gmod"]="4020"
appids["kf2"]="232130"
appid=${appids[$game]}

declare -A ex
ex["insurgency"]="$insdir/srcds_run"
ex["csgo"]="$insdir/srcds_run -game csgo -nobreakpad -usercon +game_type 0 +game_mode 1 +mapgroup mg_active +map de_inferno"
ex["avorion"]="$insdir/server.sh"
ex["gmod"]="$insdir/srcds_run -console -maxplayers 16 -game garrysmod +gamemode terrortown +map gm_construct"
ex["kf2"]="$insdir/Binaries/Win64/KFGameSteamServer.bin.x86_64 kf-bioticslab"

echo "steamctl started ------"
echo "Mode: $mode"
echo "Game: $game"
echo "AppID: $appid"
echo "Dir: $insdir"
echo "-----------------------"

if [ $mode == "install" -o $mode == "update" -o $mode == "run" -o $mode == "start" ]; then
        echo "*************************"
        echo "Updating $game"
        echo "*************************"
        dir="+force_install_dir $insdir"
        cmd="$steam $login $dir +app_update $appid +quit"
        echo "$cmd"
        eval "$cmd"
        echo "*************************"
        echo "Steam finished"
        echo "*************************"
        echo ""
fi
if [ $mode == "start" -o $mode == "run" ]; then
        echo "*************************"
        echo "Starting $game"
        echo "*************************"
        cmd=${ex[$game]}
        echo "$cmd"
        eval "$cmd"
        echo "*************************"
        echo "$game exited"
        echo "*************************"
fi

echo "steamctl finished ----"

exit $!

