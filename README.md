# docker-couchpotato

[![Build Status](https://travis-ci.org/b225ccc/docker-couchpotato.svg?branch=master)](https://travis-ci.org/b225ccc/docker-couchpotato)


Running:

~~~ sh
docker run \
  --name couchpotato \
  -v /etc/localtime:/etc/localtime:ro \
  -v /data/services/couchpotato/config:/config \
  -v /data/services/couchpotato/downloads:/downloads \ 
  -v /data/movies:/movies \
  -p 5050 \
  b225ccc/docker-couchpotato:latest
~~~
