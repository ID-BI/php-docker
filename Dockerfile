FROM php:7.3-alpine
LABEL maintainer="IDBI <nick.aguilar@idbi.pe>"

RUN apk update && apk upgrade

RUN apk add --update git \
    python \
    python-dev \
    py-pip \
    build-base \
    zip \
    unzip

RUN pip install --upgrade awscli s3cmd python-magic && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*

# Download and install php extensions
ADD php/00-install.sh /usr/sbin/install-php.sh
RUN /usr/sbin/install-php.sh

# Download and install NodeJS
ADD nodejs/00-install.sh /usr/sbin/install-node.sh
RUN /usr/sbin/install-node.sh
