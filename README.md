Neos CMS and Flow appserver.io docker image for dev's
=========================================================

##Summary
The main goal of this project is to give as many people as possible a simple and powerful access to a Neos CMS and Flow dev environment based on appserver.io. If you need more information regading the [appserver.io](http://appserver.io) project please visit the website.

Configure the docker-compose.yaml to your needs und you are ready to go.

##ENV varibales
```php
APPSERVER_PHP_MEMORY_LIMIT=512M
APPSERVER_OVERRIDE_APPSERVER_CONF=TRUE // override appserver default conf to run on port 80 (default port 8090)
APPSERVER_OVERRIDE_VHOST_CONF=TRUE // overide vhost setup and provide a preconfigured vhost for Flow and Neos CMS applications
APPSERVER_VHOST_WEB_ROOT=Web //override web root dir
APPSERVER_OVERRIDE_REDIS_CONF=FALSE // enable redis if needed
APPSERVER_VHOST_DOMAIN=xxx.whatever // set a custom domain - docker.vm is always available
```

##Interactive goodies
If you have access to an interactive container you can use this commands out of the box:

###general
```php
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias h="history"
alias c="composer"
alias g="git"
alias ll="ls -l"
alias la="ls -la"
```

###flow
```php
alias f='./flow'
alias fh='./flow help'
alias flow="./flow"
alias fcf='flow flow:cache:flush'
alias fcff='flow flow:cache:flush --force'
alias fcw='flow cache:warmup'
alias fcffw='fcff; fcw'
alias fcv="flow configuration:validate —type"
```

##How does it work
The appserver will listen on configured port with document root `/var/www/{public}` for a Neos setup. Usualy we mount `/var/www` as project root in the volumes configuration.

##Example configuration
```yaml
webco_storage:
  image: busybox
  volumes:
    - /data
webco_mysql:
  image: mariadb:latest
  volumes_from:
    - webco_storage
  environment:
    - MYSQL_ROOT_PASSWORD=root
  ports:
    - 3306:3306
webco_flow:
  image: webandco/ubuntu-supervisor-appserver-flow
  links:
      - webco_mysql:mysql
  ports:
    - 80:80
    - 443:443
  volumes:
    - ~/development/git/xxx001:/var/www
  environment:
    - APPSERVER_PHP_MEMORY_LIMIT=512M
    - APPSERVER_OVERRIDE_APPSERVER_CONF=TRUE
    - APPSERVER_OVERRIDE_VHOST_CONF=TRUE
    - APPSERVER_OVERRIDE_REDIS_CONF=FALSE
    - APPSERVER_VHOST_DOMAIN=yourcoolproject.docker
```

##Warning
This docker image is not for production and comes with absolulty no warrenty.

##Docker hub repository
[https://hub.docker.com/r/webandco/ubuntu-supervisor-appserver-flow/](https://hub.docker.com/r/webandco/ubuntu-supervisor-appserver-flow/)

##What's next
We will improve the image to provide a very solid out of the box solution for Noes and Flow develoment. For that, we need your help and feedback.

**Pull Requests are welcome!**

## Thanks for inspiration
- [Marcin Ryzycki](https://github.com/ryzy)


