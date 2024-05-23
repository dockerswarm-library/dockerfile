#!/bin/bash

# Get IP address using the Docker service network name instead of interface name
function dockerswarm_network_addr() {
    local network_name=$1
    if [ -z "$network_name" ]; then
        echo "[dockerswarm_network_addr]: command line is not complete, network name is required"
        return 1
    fi
    # Loop through assigned IP addresses to the host
    for ip in $(hostname -i); do
        # Query the PTR record for the IP address
        local ptr_record=$(host "$ip" | cut -d ' ' -f 5)
        # If the PTR record is empty, skip to the next IP address
        if [ -z "$ptr_record" ]; then
            continue
        fi
        # Filter the PTR record to get the network name
        local service_network=$(echo "$ptr_record" | cut -d '.' -f 4)
        # Check if the network name matches the input network name
        if [[ "$service_network" == *"$network_name" ]]; then
            echo "$ip"
            return
        fi
    done

    echo "[dockerswarm_network_addr]: can't find network '$network_name'"
    return 2
}

dockerswarm_network_addr "$@"
