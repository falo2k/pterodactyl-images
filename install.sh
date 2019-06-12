#!/bin/bash
# Holdfast Installation Script
#
# Server Files: /mnt/server
rm -r /mnt/server/*

apt -y update
apt -y install wget ca-certificates unzip

mkdir -p /mnt/server/steamcmd
cd /mnt/server/steamcmd
wget -qO- http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar xvz

# SteamCMD fails otherwise for some reason, even running as root.
# This is changed at the end of the install process anyways.
chown -R root:root /mnt

export HOME=/mnt/server
cd /mnt/server/
if [ ! -z ${BETA} ]; then
    echo Beta branch
    if [ ! -z ${SRCDS_APPID} ]; then
        ./steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir /home/container +app_update ${SRCDS_APPID} -beta ${BETA} +quit
    fi
else
    if [ ! -z ${SRCDS_APPID} ]; then
        ./steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir /home/container +app_update ${SRCDS_APPID} +quit
    fi
fi

cd /mnt/server
# Download Holdfast's server files from their Dropbox location
wget -O holdfast_naw_public_servers.zip https://www.dropbox.com/sh/ppkfny3r9kcnz8x/AADiIXOrlAWPh-XbhPpimw0ja?dl=1
unzip holdfast_naw_public_servers.zip
rm holdfast_naw_public_servers.zip
mv /mnt/server/Mono /mnt/server/Mono.ignore
#cp serverconfig_server1_armybattlefield.txt serverconfig.txt
echo '
###- Server & Steam Ports (All 3 ports must be unique per server instance).

server_port 20101
steam_communications_port 8701
steam_query_port 27001

###- Server Settings
server_name Holdfast Server
server_welcome_message Welcome message
server_region europe
server_password password
server_admin_password adminpassword

###- Bandwidth & Memory Settings
network_broadcast_mode LowBandwidth
# Options are LowBandwidth, PublicPlay, HighAccuracy

###- Global Gameplay Settings
artillery_fieldgun_respawn_timer 120

###- Map Rotations - Linebattle Hardcore Set - Infinite Respawns
#01. Training Grounds
#02. Tahir Desert 
#03. Grassy Plains
#04. Grassy Plains 2
#05. Grassy Plains 3
#06. Snowy Plains 
#07. Snowy Plains 2
#08. Snowy Plains 3
#09. Snowy Plains 4
#10. Snowy Plains 5
#11. Snowy Plains Small
#12. Desert Plains
#13. Desert Plains Small
#14. Ancient Plains
#15. Palisade Arena (Melee arena)
#16. Palisade Deathmatch
#17. Canyon
#18. Crosshills
#19. Training Grounds with 21 Guns

###- Map Rotations - Linebattle Hardcore Set

#Rotation 1 = Training Grounds [Army Battlefield] - Calm Weather | Day
!map_rotation start
map_name TrainingGrounds
game_mode ArmyBattlefield
round_time_minutes -1
reinforcements_per_faction 9000
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning true
allow_faction_switching true
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 8
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
rc set windDirectionAffectsShipSpeed true
rc set characterInfiniteFirearmAmmo false
rc set characterWeaponApplyHorizontalDeviation true
rc set characterWeaponFirearmApplyDrop true
rc set characterGodMode false
rc set characterJumpForce 1
rc set characterRunSpeed 1
rc set characterWalkSpeed 1
rc set characterFallDamageEnabled true
rc set ragdollForceMultiplier 1
rc set drawFirearmTrajectories false
rc set drawCannonPathTrajectories false
rc set cannonMoverSpeedMultiplier 1
rc set cannonMoverRotationMultiplier 1
rc set ladderMoverSpeedMultiplier 1
rc set ladderMoverRotationMultiplier 1
rc set rocketMoverSpeedMultiplier 1
rc set rocketMoverRotationMultiplier 1
# Parade Ground Chairs - Aux Major
objects_override Chair1 561.5 10.5 419.7 0 67 0
objects_override Chair1 561.75 10.5 419.1 0 67 0
objects_override Chair1 562 10.5 418.5 0 67 0
# Parade Ground Treehouse - Rifle Major
objects_override Chair2 566.7 12.5 409.9 0 348.5 0
objects_override Chair2 567.3 12.5 410 0 21 0
objects_override Chair2 567.8 12.5 409.75 0 50 0
objects_override Chair3 567.15 14.5 409.5 0 21 0
#objects_override Chair3 567 14.5 409.75 0 21 0
#objects_override Chair3 566.5 14.5 409.75 0 21 0
#objects_override Chair3 567.8 14.5 409.6 0 21 0
#objects_override Chair3 567.7 16.5 409.7 0 21 0
# Parade Ground Flags - Behind Podium
objects_override FlagBritish 562.2 10.7 417.8 0 75 0
objects_override FlagBritish 564.8 10.7 410.4 0 75 0
# Church - Weapon Racks Back Room
objects_override WeaponRack 556.5 10.1 434 0 102 0 Knife 100
objects_override WeaponRack 557 10.1 431 0 70 0 Axe 100
objects_override WeaponRack 558.3 10.1 428.5 0 32 0 Dagger 100
# Parade Ground - Lantern Box Behind Tree
objects_override Lanternbox 566.8 10.5 409 0 214 0
# Blunder Blitz - Axe racks outside the town gates
objects_override WeaponRack 441 10.1 453.5 0 164.5 0 Axe 100
objects_override WeaponRack 430 10.1 451 0 164.5 0 Axe 100
# Parade Ground Arty (L to R)
objects_override CannonFieldGun9PDRMoveable 603 10.6 394.4 0 314.5 0
objects_override CannonAmmoboxLargeMoveable 600.7 10.6 394.1 0 318.7 0
objects_override CannonFieldGun9PDRMoveable 605.7 10.7 398.5 0 305.0 0
objects_override CannonAmmoboxLargeMoveable 604 10.7 398 0 304.0 0
objects_override CannonFieldGun9PDRMoveable 608.9 10.85 402.6 0 304.0 0
objects_override CannonAmmoboxLargeMoveable 607.2 10.7 401.8 0 301.2 0
!map_rotation end


#Rotation 2 = Tahir Desert [Army Assault] - Calm Weather | Dynamic
!map_rotation start
map_name Egypt
game_mode ArmyAssault
round_time_minutes 20
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning false
allow_faction_switching false
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 14
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
#faction_attacking British
#faction_defending French
!map_rotation end


#Rotation 3 = Grassy Plains [Army Assault] - Calm Weather | Dynamic
!map_rotation start
map_name grassyplains
game_mode ArmyAssault
round_time_minutes 20
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning false
allow_faction_switching false
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 14
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end


#Rotation 4 = Grassy Plains II [Army Assault] - Dynamic Weather | Morning
!map_rotation start
map_name GrassyPlainsII
game_mode ArmyAssault
round_time_minutes 20
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning false
allow_faction_switching false
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 8
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end

 
#Rotation 5 = Grassy Plains III [Army Assault] - Dynamic Weather | Morning
!map_rotation start
map_name GrassyPlainsIII
game_mode ArmyAssault
round_time_minutes 20
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning false
allow_faction_switching false
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 8
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end


#Rotation 6 = Snowy Plains [Army Assault] - Calm Weather | Day
!map_rotation start
map_name snowyplains
game_mode ArmyAssault
round_time_minutes 20
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning false
allow_faction_switching false
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 8
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end


#Rotation 7 = Snowy Plains II [Army Assault] - Calm Weather | Dynamic
!map_rotation start
map_name snowyplainsii 
game_mode ArmyAssault
round_time_minutes 20
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning false
allow_faction_switching false
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 8
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end


#Rotation 8 = Snow Plains III [Army Assault] - Calm Weather | Dynamic
!map_rotation start
map_name snowyplainsiii 
game_mode ArmyAssault
round_time_minutes 20
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning false
allow_faction_switching false
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 8
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end


#Rotation 9 = Snow Plains IV [Army Assault] - Calm Weather | Dynamic
!map_rotation start
map_name Snowyplainsiv
game_mode ArmyAssault
round_time_minutes 20
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning false
allow_faction_switching false
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 9
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end



#Rotation 10 = Snow Plains V [Army Assault] - Calm Weather | Dynamic
!map_rotation start
map_name Snowyplainsv
game_mode ArmyAssault
round_time_minutes 20
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning false
allow_faction_switching false
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 9
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end


#Rotation 11 = Snow Plains Small [Army Assault] - Calm Weather | Dynamic
!map_rotation start
map_name Snowyplainssmall 
game_mode ArmyAssault
round_time_minutes 20
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning false
allow_faction_switching false
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 9
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end


#Rotation 12 = Desert Plains [Army Assault] - Calm Weather | Day
!map_rotation start
map_name DesertPlains
game_mode ArmyAssault
round_time_minutes 20
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning false
allow_faction_switching false
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 9
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end


#Rotation 13 = Desert Plains Small [Army Assault] - Calm Weather | Day
!map_rotation start
map_name Desertplainssmall
game_mode ArmyAssault
round_time_minutes 20
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning false
allow_faction_switching false
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 9
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end


#Rotation 14 = Ancient Plains [Army Assault] - Calm Weather | Day
!map_rotation start
map_name Ancientplains
game_mode ArmyAssault
round_time_minutes 20
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning false
allow_faction_switching false
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 9
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end

 
#Rotation 15 = Palisade Arena [Melee Arena] - Calm Weather | Day
!map_rotation start
map_name Palisadearena
game_mode Meleearena
round_time_minutes 10
reinforcements_per_faction 200
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
round_spawn_close_timer_seconds 30
round_spawn_close_timer_seconds_between_rounds 10
amount_of_rounds 99
allow_midround_spawning false
allow_faction_switching true
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 9
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end


#16 = Palisade Arena (Army Deathmatch) - Calm Weather | Morning (8)
!map_rotation start
map_name palisadearena
game_mode ArmyDeathmatch
deathmatch_max_kills 5000
round_time_minutes 9999
faction_balancing false
allow_faction_switching true
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 8
time_dynamic false
weather_preset calm
weather_dynamic false
melee_weapons_only true
faction_attacking french
faction_defending british
!map_rotation end

#Rotation 17 = Canyon [Army Assault] - Calm Weather | Day
!map_rotation start
map_name Canyon
game_mode ArmyBattlefield
round_time_minutes -1
reinforcements_per_faction 9000
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning true
allow_faction_switching true
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 8
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end


#Rotation 18 = Crosshills [Army Assault] - Calm Weather | Day
!map_rotation start
map_name Crosshills
game_mode ArmyBattlefield
round_time_minutes -1
reinforcements_per_faction 9000
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning true
allow_faction_switching true
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 8
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
!map_rotation end

#Rotation 19 = Training Grounds 21 guns
!map_rotation start
map_name TrainingGrounds
game_mode ArmyBattlefield
round_time_minutes -1
reinforcements_per_faction 9000
wave_spawn_time_seconds 1
max_player_respawns -1
faction_balancing false
allow_midround_spawning true
allow_faction_switching true
allow_spectating true
minimum_players -1
maximum_players 150
time_hour 8
time_dynamic false
friendly_fire true
weather_preset calm
weather_dynamic false
game_type hardcore
rc set windDirectionAffectsShipSpeed true
rc set characterInfiniteFirearmAmmo false
rc set characterWeaponApplyHorizontalDeviation true
rc set characterWeaponFirearmApplyDrop true
rc set characterGodMode false
rc set characterJumpForce 1
rc set characterRunSpeed 1
rc set characterWalkSpeed 1
rc set characterFallDamageEnabled true
rc set ragdollForceMultiplier 1
rc set drawFirearmTrajectories false
rc set drawCannonPathTrajectories false
rc set cannonMoverSpeedMultiplier 1
rc set cannonMoverRotationMultiplier 1
rc set ladderMoverSpeedMultiplier 1
rc set ladderMoverRotationMultiplier 1
rc set rocketMoverSpeedMultiplier 1
rc set rocketMoverRotationMultiplier 1
# Parade Ground Chairs - Aux Major
objects_override Chair1 561.5 10.5 419.7 0 67 0
objects_override Chair1 561.75 10.5 419.1 0 67 0
objects_override Chair1 562 10.5 418.5 0 67 0
# Parade Ground Treehouse - Rifle Major
objects_override Chair2 566.7 12.5 409.9 0 348.5 0
objects_override Chair2 567.3 12.5 410 0 21 0
objects_override Chair2 567.8 12.5 409.75 0 50 0
objects_override Chair3 567.15 14.5 409.5 0 21 0
# Parade Ground Flags - Behind Podium
objects_override FlagBritish 562.2 10.7 417.8 0 75 0
objects_override FlagBritish 564.8 10.7 410.4 0 75 0
# Church - Weapon Racks Back Room
objects_override WeaponRack 556.5 10.1 434 0 102 0 Knife 100
objects_override WeaponRack 557 10.1 431 0 70 0 Axe 100
objects_override WeaponRack 558.3 10.1 428.5 0 32 0 Dagger 100
# Parade Ground - Lantern Box Behind Tree
objects_override Lanternbox 566.8 10.5 409 0 214 0

# Parade Ground Arty (L to R)
objects_override CannonFieldGun9PDRMoveable 609 10.8 402.8 0 304 0
objects_override CannonFieldGun9PDRMoveable 606 10.8 398 0 304 0
objects_override CannonFieldGun9PDRMoveable 603.1 10.7 394.4 0 304 0
objects_override CannonFieldGun9PDRMoveable 600 10.7 390 0 303 0
objects_override CannonFieldGun9PDRMoveable 597.3 10.6 386.2 0 304 0
objects_override CannonFieldGun9PDRMoveable 594.4 10.6 382.1 0 304 0
objects_override CannonFieldGun9PDRMoveable 591.5 10.7 378 0 304 0
objects_override CannonAmmoboxLargeMoveable 607.7 10.9 401.4 0 304 0
objects_override CannonAmmoboxLargeMoveable 604.8 10.8 397.3 0 304 0
objects_override CannonAmmoboxLargeMoveable 601.9 10.7 393.2 0 304 0
objects_override CannonAmmoboxLargeMoveable 599 10.7 389.1 0 304 0
objects_override CannonAmmoboxLargeMoveable 596.1 10.6 385 0 304 0
objects_override CannonAmmoboxLargeMoveable 593.2 10.6 380.9 0 304 0
objects_override CannonAmmoboxLargeMoveable 590.3 10.7 376.8 0 304 0
objects_override CannonFieldGun9PDRMoveable 610.6 10.8 398.1 0 304 0
objects_override CannonFieldGun9PDRMoveable 607.7 10.7 394 0 304 0
objects_override CannonFieldGun9PDRMoveable 604.8 10.7 389.9 0 304 0
objects_override CannonFieldGun9PDRMoveable 601.9 10.7 385.8 0 304 0
objects_override CannonFieldGun9PDRMoveable 599 10.6 381.7 0 304 0
objects_override CannonFieldGun9PDRMoveable 596.1 10.7 377.6 0 304 0
objects_override CannonFieldGun9PDRMoveable 593.2 10.7 373.5 0 304 0
objects_override CannonAmmoboxLargeMoveable 609.4 10.8 396.9 0 304 0
objects_override CannonAmmoboxLargeMoveable 606.5 10.7 392.8 0 304 0
objects_override CannonAmmoboxLargeMoveable 603.6 10.7 388.7 0 304 0
objects_override CannonAmmoboxLargeMoveable 600.7 10.7 384.6 0 304 0
objects_override CannonAmmoboxLargeMoveable 597.8 10.6 380.5 0 304 0
objects_override CannonAmmoboxLargeMoveable 594.9 10.7 376.4 0 304 0
objects_override CannonAmmoboxLargeMoveable 592 10.7 372.3 0 304 0
objects_override CannonFieldGun9PDRMoveable 612.8 10.9 393.4 0 304 0
objects_override CannonFieldGun9PDRMoveable 609.9 10.8 389.3 0 304 0
objects_override CannonFieldGun9PDRMoveable 607 10.8 385.2 0 304 0
objects_override CannonFieldGun9PDRMoveable 604.1 10.8 381.1 0 304 0
objects_override CannonFieldGun9PDRMoveable 601.2 10.8 377 0 304 0
objects_override CannonFieldGun9PDRMoveable 598.3 10.8 372.9 0 304 0
objects_override CannonFieldGun9PDRMoveable 595.4 10.9 368.8 0 304 0
objects_override CannonAmmoboxLargeMoveable 611.6 10.9 392.2 0 304 0
objects_override CannonAmmoboxLargeMoveable 608.7 10.8 388.1 0 304 0
objects_override CannonAmmoboxLargeMoveable 605.8 10.8 384 0 304 0
objects_override CannonAmmoboxLargeMoveable 602.9 10.8 379.9 0 304 0
objects_override CannonAmmoboxLargeMoveable 600 10.8 375.8 0 304 0
objects_override CannonAmmoboxLargeMoveable 597.1 10.8 371.7 0 304 0
objects_override CannonAmmoboxLargeMoveable 594.2 10.9 367.6 0 304 0

# Blunder Blitz - Axe racks outside the town gates
objects_override WeaponRack 441 10.1 453.5 0 164.5 0 Axe 100
objects_override WeaponRack 430 10.1 451 0 164.5 0 Axe 100

!map_rotation end

' > serverconfig.txt

chmod 755 /mnt/server/*
