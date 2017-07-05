FROM debian:7

MAINTAINER Shay Cohen version: 0.1

ENV DEBIAN_FRONTEND noninteractive
ENV VAR val

RUN apt-get update && apt-get install -y supervisor postfix && apt-get clean && rm -rf /var/lib/apt/lists/*

ADD mailgw.sh /opt/mailgw.sh
ADD supervisord.conf /etc/supervisor/supervisord.conf

EXPOSE 25

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]

