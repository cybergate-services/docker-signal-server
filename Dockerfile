FROM debian:buster as build
RUN apt-get update && apt-get install -y openjdk-11-jdk-headless maven git
RUN git -C /usr/local/src clone https://github.com/signalapp/Signal-Server
WORKDIR /usr/local/src/Signal-Server
COPY signal-server-patches /tmp/signal-server-patches
RUN chmod +x /tmp/signal-server-patches/apply-patches.sh
RUN /tmp/signal-server-patches/apply-patches.sh
RUN mvn install -DskipTests

FROM debian:buster
RUN apt-get update && apt-get install -y openjdk-11-jre-headless
COPY --from=build /usr/local/src/Signal-Server/service/target/TextSecureServer-2.55.jar /usr/share/TextSecureServer.jar
COPY --from=build /usr/local/src/Signal-Server/websocket-resources/target/websocket-resources-2.55.jar /usr/share/websocket-resources-2.55.jar

COPY migrate-and-start-server.sh /usr/bin/migrate-and-start-server
RUN chmod +x /usr/bin/migrate-and-start-server
RUN useradd signal
RUN chown -R signal /usr/share/TextSecureServer.jar
USER signal
CMD ["/usr/bin/migrate-and-start-server"]
