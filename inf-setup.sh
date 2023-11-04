#!/bin/bash
# Function to set a static IP
set_static_ip() {
    local iface="$1"
    local ip="$2"
    local netmask="$3"
    sudo ifconfig "$iface" "$ip" netmask "$netmask"
    echo "Static IP set to $ip with netmask $netmask on interface $iface."
}

# Function to revert to DHCP
set_dhcp() {
    local iface="$1"
    sudo dhclient -r "$iface"  # release current IP
    sudo dhclient "$iface"  # renew IP from DHCP
    echo "Interface $iface is now using DHCP."
}

# ASCII Art and Authorship
print_ascii_art() {
    echo "__________                  __  ___________        ___________"
    echo "\______   \  ____    ____ _/  |_\_   _____/___  ___\_   _____/"
    echo " |       _/ /  _ \  /  _ \\   __\|    __)_ \  \/  / |    __)_ "
    echo " |    |   \(  <_> )(  <_> )|  |  |        \ >    <  |        \\"
    echo " |____|_  / \____/  \____/ |__| /_______  //__/\_ \/_______  /"
    echo "        \/                              \/       \/        \/"
    echo ""
    echo "# Author: Ross Brereton (https://www.linkedin.com/in/ross-b-673872107/)"
    echo "# Website: https://github.com/msf-Root-ExE"
}

# Menu
while true; do
    print_ascii_art
    echo "1. Set static IP"
    echo "2. Use DHCP"
    echo "3. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1)
            read -p "Enter interface (e.g., eth0, wlan0): " interface
            read -p "Enter desired IP address: " ip
            read -p "Enter netmask (e.g., 255.255.255.0): " netmask
            set_static_ip "$interface" "$ip" "$netmask"
            ;;
        2)
            read -p "Enter interface to revert to DHCP: " interface
            set_dhcp "$interface"
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice."
            ;;
    esac
done
