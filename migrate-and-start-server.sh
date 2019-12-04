#!/bin/bash
set -exu
java -jar /usr/share/TextSecureServer.jar abusedb migrate /etc/Signal.yml
java -jar /usr/share/TextSecureServer.jar accountdb migrate /etc/Signal.yml
java -jar /usr/share/TextSecureServer.jar messagedb migrate /etc/Signal.yml
java -jar /usr/share/TextSecureServer.jar server /etc/Signal.yml
#java -jar  /usr/share/websocket-resources-2.55.jar

