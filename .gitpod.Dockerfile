FROM gitpod/workspace-mongodb

USER root

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude="./bin" && \
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin

RUN set -ex; \
    mkdir -p /workspace/data; \
    mkdir -p /etc/services.d/mongod; \
    printf "#!/usr/bin/execlineb -P\nmongod --dbpath /workspace/data" > /etc/services.d/mongod/run

ENTRYPOINT [ "/init" ]
