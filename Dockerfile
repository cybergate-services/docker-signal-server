FROM  maven:3.6.2-jdk-11-slim
LABEL maintainer "Chinthaka Deshapriya <chinthaka@cybergate.lk>"

ARG DEBIAN_FRONTEND=noninteractive
ENV LC_ALL C
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y --no-install-recommends \
  cron \
  wget \
  git

# Clone the signal server codes
RUN cd /opt
RUN git clone https://github.com/cybergate-services/Signal-Server.git

# Compile Signal Server
RUN cd /opt/Signal-Server
RUN source /etc/profile.d/maven.sh
RUN mvn install -DskipTests

# Install Signal Server 
COPY ./ /Signal-Server

# Run server
EXPOSE 8080
EXPOSE 8081

CMD ["/bin/bash", "-c", "java -jar /Signal-Server/target/TextSecureServer-2.55.jar server /Signal-Server/config/Signal.yml"]
