FROM debian:buster-slim
LABEL maintainer "Chinthaka Deshapriya <chinthaka@cybergate.lk>"

ARG DEBIAN_FRONTEND=noninteractive
ENV LC_ALL C
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  cron \
  gettext \
  gnupg \
  rsync \
  wget \
  git

# Install Java
RUN apt-get install -y default-jre \
  default-jdk 

# Install Apache Maven
RUN apt-get install maven -y 

# Setup enviorenment variables
COPY /conf/maven.sh  /etc/profile.d/
RUN chmod +x  /etc/profile.d/maven.sh

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



