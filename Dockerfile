FROM alpine:3.11
MAINTAINER MFV <devops@moneyforward.vn>

RUN apk add --no-cache \
    squid \
    apache2-utils

RUN sed -i 's@^http_access allow localhost$@\0\nhttp_access allow ncsa_users@' /etc/squid/squid.conf
RUN sed -i '1i auth_param basic program /usr/lib/squid/basic_ncsa_auth /usr/etc/passwd\nacl ncsa_users proxy_auth REQUIRED' /etc/squid/squid.conf
RUN sed -i 's/^http_access allow localnet/# http_access allow localnet/g' /etc/squid/squid.conf

RUN mkdir /usr/etc

EXPOSE 3128
VOLUME /var/log/squid

ADD init /init
CMD ["/init"]
