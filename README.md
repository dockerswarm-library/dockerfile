# dockerfile
A collections of scripts and tools used for building Container Images

## Tips and Tricks

### Resole domain IP address using Docker Service Discovery

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
