# Caucho Resin Web Server for Docker

![Docker Build Status](https://img.shields.io/docker/build/nidr0x/caucho-resin.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/nidr0x/caucho-resin.svg) ![Docker Stars](https://img.shields.io/docker/stars/nidr0x/caucho-resin.svg)

Docker container with Caucho Resin Web Server.

## Features ##
- Multistage spec
- Built on UBI (Universal Base Image) as base to take advantage of OpenShift and non-OpenShift environments
- Ready for production

## Usage ##
**Example:**

Build:

`$ docker build -t caucho-resin .`

Running client:

`$ docker run --rm -it caucho-resin resinctl version`
