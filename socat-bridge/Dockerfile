ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.16
FROM ${BUILD_FROM}

# Installa socat
RUN apk add --no-cache socat

# Copia lo script di avvio
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]