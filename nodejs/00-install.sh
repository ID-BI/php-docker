#!/bin/sh

# Install current LTS node version
apk add -U nodejs

# Install latest NPM
apk add -U npm

# Install Yarn
npm i -g yarn

# Install build dependencies
apk add autoconf automake g++ gcc libpng-dev libtool make nasm python
