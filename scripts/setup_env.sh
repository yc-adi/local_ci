#!/usr/bin/env zsh

echo "##############"
echo "# setup_env.sh"
echo "##############"
mkdir -p /home/$USER/ws

printf "\n--- prepare local_ci\n"
if [ ! -d /home/$USER/ws/local_ci ]; then
    echo "git clone ..."
else
    cd /home/$USER/ws/local_ci
    git log | head
    echo ""
    git status
fi

printf "\n--- prepare msdk_dev_tools\n"
if [ ! -d /home/$USER/ws/msdk_dev_tools ]; then
    echo "git clone ..."
else
    cd /home/$USER/ws/msdk_dev_tools
    git log | head -5
    echo ""
    git status
fi

echo "DONE: setup_env.sh"


