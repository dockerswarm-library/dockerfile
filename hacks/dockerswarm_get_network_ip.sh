#!/bin/bash

# Do a reverse lookup on the IP address to get the network name
function dockerswarm_get_network_ip() {
    local network_name=$1
    # Loop through assigned IP addresses to the host
    for ip in $(hostname -i); do
        # Query the PTR record for the IP address
        local ptr_record=$(host "$ip" | cut -d ' ' -f 5)
        # Filter the PTR record to get the network name
        local service_network=$(echo "$ptr_record" | cut -d '.' -f 4)
        # Check if the network name matches the input network name
        if [[ "$service_network" == *"$network_name" ]]; then
            echo "$ip"
            break
        fi
    done
}

dockerswarm_get_network_ip "$@"
