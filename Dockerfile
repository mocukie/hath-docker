FROM --platform=${TARGETPLATFORM} openjdk:8-jre-alpine

ARG HatH_VERSION
ARG HatH_CHECKSUM

RUN set -eux && \
    apk add --no-cache su-exec ca-certificates\ 
    && su-exec nobody true \
    && update-ca-certificates 

RUN set -eux && \
    apk add --no-cache --virtual .buildPkg \
    curl unzip  
    
RUN set -eux && \
    mkdir -p /hath && cd /hath && \
    curl -fsSL https://repo.e-hentai.org/hath/HentaiAtHome_${HatH_VERSION}.zip -o hath.zip && \
    echo -n "$HatH_CHECKSUM  hath.zip" | sha256sum -c && \
    unzip hath.zip && \
    rm hath.zip && \
    apk del .buildPkg

RUN addgroup -S hath && adduser -S hath hath

WORKDIR /hath

COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

VOLUME ["/hath/cache", "/hath/data", "/hath/download", "/hath/log", "/hath/temp"]

ENV JVM_DEFAULT_OPT "-server"

ENTRYPOINT ["/hath/entrypoint.sh"]
