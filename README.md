# dockerfile
A collections of scripts and tools used for building Container Images

## Recommended for `docker-entrypoint.sh``

Sometime is is important to give a bit of time for the Docker engine to configure the network and DNS resolution for your serivce if you intended to use the **Docker Service Discovery** mechanism.

```sh
# !!! IMPORTANT !!!
entrypoint_log "Waiting for Docker to configure the network and DNS resolution... (${DOCKERSWARM_STARTUP_DELAY}s)"
sleep ${DOCKERSWARM_STARTUP_DELAY:-15}
```

## Tips and Tricks

### Resolve domain IP addresses using Docker Service Discovery

Docker Swarm provided the service discovery mechanism by using the `tasks.{{ service_name }}` record using the internal DNS server.
It is useful if you wish to do some magic servic disovery for custom images.

```sh
host "tasks.{{ service_name }}" | cut -d ' ' f 4 | sort
# 10.0.33.5
# 10.0.33.6
# 10.0.33.3

# is equivalent to
dig +short "tasks.{{ service_name }}" | sort
# 10.0.33.5
# 10.0.33.6
# 10.0.33.3
```
