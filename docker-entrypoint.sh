#!/bin/bash
java -jar  /Signal-Server/service/target/TextSecureServer-2.55.jar messagedb migrate /Signal-Server/service/config/Signal.yml
java -jar  /Signal-Server/service/target/TextSecureServer-2.55.jar accountdb migrate /Signal-Server/service/config/Signal.yml
