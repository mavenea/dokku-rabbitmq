# dokku rabbitmq [![Build Status](https://img.shields.io/circleci/project/github/dokku/dokku-rabbitmq.svg?branch=master&style=flat-square "Build Status")](https://circleci.com/gh/dokku/dokku-rabbitmq/tree/master) [![IRC Network](https://img.shields.io/badge/irc-freenode-blue.svg?style=flat-square "IRC Freenode")](https://webchat.freenode.net/?channels=dokku)

Forked from the Official rabbitmq plugin for dokku with a modified Dockerfile enabling [webstomp plugin](https://www.rabbitmq.com/web-stomp.html) . It currently defaults to installing [rabbitmq:3.9.5-management](https://hub.docker.com/_/rabbitmq/).

> Do not use the plugin from this repo, use the updated Dockerfile to build your own image, then use the image with the official rabbitmq plugin.
