FROM fragsoc/steamcmd-wine-xvfb

USER root
WORKDIR /
RUN DEBIAN_FRONTEND=noninteractive apt-get update

ARG UID=1000
ARG GID=1000

ENV INSTALL_DIR="/vrising"
ENV HOME=${INSTALL_DIR}

RUN mkdir -p $INSTALL_DIR && \
    groupadd -g $GID vrising && \
    useradd -m -s /bin/false -u $UID -g $GID vrising && \
    mkdir -p $INSTALL_DIR && \
    chown -R vrising:vrising ${INSTALL_DIR}

USER vrising

# Install Server
ARG APPID=1829350
ARG STEAM_BETAS
RUN ls -lha $INSTALL_DIR
RUN steamcmd \
        +force_install_dir $INSTALL_DIR \
        +login anonymous \
        +app_update $APPID $STEAM_BETAS validate \
        +app_update 1007 validate \
        +quit

WORKDIR ${INSTALL_DIR}
RUN mkdir -p server-data
ENTRYPOINT ["tini", "--", "xvfb-run", "-a", "wine", "./VRisingServer.exe", "-persistentDataPath", "./server-data"]

