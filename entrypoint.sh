#!/bin/sh
envsubst < /config/config.yml > /www/assets/config.yml
darkhttpd /www/ --no-listing --port 8080
