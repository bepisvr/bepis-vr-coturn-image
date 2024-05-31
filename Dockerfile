FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
# modified from https://raw.githubusercontent.com/forsrc/docker-coturn/master/apt-get/Dockerfile
RUN apt-get update

RUN apt-get -y install coturn openssl systemd sudo

RUN echo '#!/bin/bash'                        >  /docker-entrypoint.sh
RUN echo "if [ \"\${1:0:1}\" == '-' ]; then"  >> /docker-entrypoint.sh
RUN echo '  set -- turnserver "$@"'           >> /docker-entrypoint.sh
RUN echo 'fi'                                 >> /docker-entrypoint.sh
RUN echo 'exec $(eval "echo $@")'             >> /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
