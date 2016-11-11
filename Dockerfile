FROM alpine:3.4
MAINTAINER Ben Grindy

RUN apk add --no-cache icecast

EXPOSE 8000

USER icecast
ENTRYPOINT ["/usr/bin/icecast"]
CMD ["-c", "/etc/icecast.xml"]
