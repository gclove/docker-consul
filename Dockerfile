FROM alpine:3.8

# https://checkpoint-api.hashicorp.com/v1/check/consul?arch=amd64&os=linux
ENV CONSUL_VERSION=1.3.0

RUN cd /tmp && \
    wget https://releases.hashicorp.com/consul/1.3.0/consul_1.3.0_linux_amd64.zip && \
    cd /usr/local/bin && unzip /tmp/consul_1.3.0_linux_amd64.zip && \
    rm -rf /tmp/consul_1.3.0_linux_amd64.zip && cd /root

RUN mkdir -p /root/consul/data && mkdir -p /root/consul/config

WORKDIR /root

VOLUME /root/consul/data


# Server RPC is used for communication between Consul clients and servers for internal
# request forwarding.
EXPOSE 8300

# Serf LAN and WAN (WAN is used only by Consul servers) are used for gossip between
# Consul agents. LAN is within the datacenter and WAN is between just the Consul
# servers in all datacenters.
EXPOSE 8301 8301/udp 8302 8302/udp

# HTTP and DNS (both TCP and UDP) are the primary interfaces that applications
# use to interact with Consul.
EXPOSE 8500 8600 8600/udp


CMD ["/bin/sh"]


# By default you'll get an insecure single-node development server that stores
# everything in RAM, exposes a web UI and HTTP endpoints, and bootstraps itself.
# Don't use this configuration for production.
#
# CMD ["agent", "-dev", "-client", "0.0.0.0"]
