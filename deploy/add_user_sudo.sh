#!/bin/bash
# v0.2
# This script will ask for a user name and then add that user to sudoers with NOPASSWD option.
# Usage: curl -fsSL sudo.1one.one -o addsudo.sh; sh addsudo.sh

# Make sure we are running as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi

# Got $SUDO_USER, if it is exist
if [ -z "$1" ] && [ -n "$SUDO_USER" ]; then
    user_name=$SUDO_USER
else
    user_name=$1

    if [ -z "$user_name" ]; then
        echo "Enter the username you wish to grant sudo access to:"
        read user_name
    fi
fi

# Check if the user exists in the system
if id "$user_name" &>/dev/null; then
    # User exists, proceed to give sudo rights
    
    # Adding the user to the sudo group. This might vary based on the distro.
    # For Debian/Ubuntu, it's sudo group
    usermod -aG sudo $user_name
    
    # For RHEL/CentOS, it's wheel group
    # usermod -aG wheel $user_name
    
    # Add user to sudoers file without password requirement
    echo "$user_name ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$user_name
    
    # Setting correct permissions on the sudoers file we just created
    chmod 0440 /etc/sudoers.d/$user_name
    
    echo "User $user_name has been granted sudo access without a password."
else
    # The user does not exist
    echo "The user $user_name does not exist."
    exit 1
fi
