#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "shutdown"
    echo "reboot"
    echo "lock"
    echo "suspend"
    echo "hibernate"
    echo "logout"
    exit
fi

case "$1" in
    shutdown)
        systemctl poweroff
        ;;
    reboot)
        systemctl reboot
        ;;
    lock)
        loginctl lock-session
        ;;
    suspend)
        systemctl suspend
        ;;
    hibernate)
        systemctl hibernate
        ;;
    logout)
        loginctl terminate-session self
        ;;
esac
