#!/bin/bash

# First, make sure that we're running as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 
   exit 1
fi

# Assuming the environment variable is set outside the script. For demonstration, we'll receive it as a script argument
# Normally, you would have the user set like: user=$USER_NAME
# To execute script: sudo ./script_name.sh $USER_NAME
user=$1

# Check if the user exists
if id "$user" &>/dev/null; then
    # User exists, proceed to give sudo rights
    # For Ubuntu/Debian, 'sudo' group is used
    usermod -aG sudo $user

    # For CentOS/RHEL, 'wheel' group is used
    # usermod -aG wheel $user
    # We echo a string into the sudoers file. NEVER edit this file manually in a script, so we use tee
    echo "$user ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/$user    
    echo "User $user now has sudo rights without a password requirement."
else
    # User doesn't exist
    echo "User $user does not exist."
    exit 1
fi
