#!/bin/sh

# Thanks to SwinGame's build.sh :)

#
# Step 1: Detect the operating system
#
MAC="Mac OS X"
WIN="Windows"
LIN="Linux"

if [ `uname` = "Darwin" ]; then
    OS=$MAC
elif [ `uname` = "Linux" ]; then
    OS=$LIN
else
    OS=$WIN
fi

echo Building SwinAdventure!

# Move to src dir
APP_PATH=`echo $0 | awk '{split($0,patharr,"/"); idx=1; while(patharr[idx+1] != "") { if (patharr[idx] != "/") {printf("%s/", patharr[idx]); idx++ }} }'`
APP_PATH=`cd "$APP_PATH"; pwd`
cd "$APP_PATH"

if [ "$OS" = "$MAC" ]; then
g++ -std=c++11 "$APP_PATH/src/main.cpp" -o "$APP_PATH/bin/SwinAdventure"

elif [ "$OS" = "$WIN" ]; then
	g++ -std=c++11 "$APP_PATH/src/main.cpp" -o "$APP_PATH/bin/SwinAdventure.exe"

elif [ "$OS" = "$LIN" ]; then
	g++ -std=c++11 "$APP_PATH/src/main.cpp" -o "$APP_PATH/bin/SwinAdventure"
fi

echo
echo Done! Running...
echo
echo Use 'help' to see commands
echo
echo
if [ "$OS" = "$MAC" ]; then
    "$APP_PATH/bin/SwinAdventure"

elif [ "$OS" = "$WIN" ]; then
    "$APP_PATH/bin/SwinAdventure.exe"

elif [ "$OS" = "$LIN" ]; then
    "$APP_PATH/bin/SwinAdventure"
fi