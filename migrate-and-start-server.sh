#!/bin/bash
set -exu
java -jar /usr/share/TextSecureServer.jar abusedb migrate /etc/signal-server.yaml
java -jar /usr/share/TextSecureServer.jar accountdb migrate /etc/signal-server.yaml
java -jar /usr/share/TextSecureServer.jar messagedb migrate /etc/signal-server.yaml
java -jar /usr/share/TextSecureServer.jar server /etc/signal-server.yaml
