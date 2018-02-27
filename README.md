# Gem in a Box in Docker

Geminabox lets you host your own gems, and push new gems to it just like with rubygems.org. Read more [here](https://github.com/geminabox/geminabox).

# Running 

    docker run -d -p 9292:9292 --name geminabox cristianbica/geminabox:latest
    
# Configuration

There are some configs that can be set through docker environment variables (`docker run -e VAR=value -e VAR2=value2`)

## Port

You can set the port geminabox server (puma) will listen on in the container with `GEMINABOX_PORT` (default: 9292)

    docker run -d -p 80:80 --name geminabox -e GEMINABOX_PORT=80  cristianbica/geminabox:latest

## Storage

By default geminabox will store the gem data in `/app/data` but you can change that by passing `GEMINABOX_PATH`

    docker run -d -p 9292:9292 --name geminabox -e GEMINABOX_PATH=/data -v /my/persistent/data:/data cristianbica/geminabox:latest

## Restricting access

Usually you would run geminabox for private gems. The options to restrict access are:

- `GEMINABOX_USERNAME` and `GEMINABOX_PASSWORD` will be used as HTTP Basic auth (by default blank which means no auth) for push and yank-ing gems
- `GEMINABOX_PREFIX` is the path prefix of your gem source (Default `/`)
- `GEMINABOX_PRIVATE` will make pulling gems also restricted by username and password

The common setup for private gems is to have a randomly generated prefix which will provide some basic protection for reading gems and easier configuration in your `Gemfile` (`source "https://my.gem.server/prefix"`) and have the Basic auth to push gems (`gem inabox --host https://user:pass@my.gem.server/prefix`)
