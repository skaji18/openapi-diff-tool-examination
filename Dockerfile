FROM debian:trixie-20231120-slim

WORKDIR /app
RUN mkdir -p /app/bin

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG version="1.10.0"
RUN wget -O - https://github.com/Tufin/oasdiff/releases/download/v${version}/oasdiff_${version}_linux_arm64.tar.gz \
    | tar zxvf - -C /app/bin \
    && chmod +x /app/bin/oasdiff


WORKDIR /app/resources
ENTRYPOINT [ "/app/bin/oasdiff", "diff", "-f", "text" ]
CMD [ "previous_spec.yml", "current_spec.yml" ]
