# ubuntu-base
minimal ubuntu container with a bit of opinionated tweaks

# how-to-use
```sh
make container
```

# tweaks introduced
## reasonable apt configs
you will be assuming `apt-get -y --no-install-recommends` options
## turning apt cache on to perform build cache
buildkit is the way to go!
Try
```dockerfile
RUN \
	--mount=type=cache,target=/var/lib/apt/lists \
	--mount=type=cache,target=/var/cache/apt/archives \
	apt-get update
```
## replacing mirrors
you can override the mirrors by passing `$APT_MIRROR_PRIORITY1` and `$APT_MIRROR_PRIORITY2` as build arguments. defaults to Japan mirrors.
## adding `curl` and `ca-certificates`
you will anyway add these especially when you want to run arbitrary scripts from github.
