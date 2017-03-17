FROM ubuntu:16.04

MAINTAINER b225ccc@gmail.com

# install dependencies
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl git supervisor && \
  apt-get install -y libxslt1-dev libxslt1.1 libxml2-dev \
    libxml2 libssl-dev libffi-dev python-pip python-dev libssl-dev && \
  apt-get install -y python-openssl python-lxml python-pyparsing && \
  rm -rf /var/lib/apt/lists/*

RUN \
  mkdir -p /var/log/supervisor

# build unrar
RUN \
  cd /tmp && \
  curl -o unrarsource.tar.gz http://rarlab.com/rar/unrarsrc-5.2.7.tar.gz && \
  tar -xvf /tmp/unrarsource.tar.gz && \
  cd unrar && \
  make -f makefile && \
  install -v -m755 unrar /usr/bin && \
  rm -rf /tmp/unrar*

# create couchpotato user and add media group
# user will default to the 'nogroup' group
RUN \
  groupadd --system --gid 1001 media && \
  adduser --system --uid 65002 --no-create-home couchpotato && \
  usermod -aG media couchpotato

# add custom files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN \
  git clone -q git://github.com/RuudBurger/CouchPotatoServer.git /opt/couchpotato && \
  chown couchpotato:nogroup -R /opt/couchpotato

# volumes
VOLUME /config /downloads /movies

# ports
EXPOSE 5050

CMD ["/usr/bin/supervisord"]
