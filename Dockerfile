FROM alpine:3.14

RUN apk update && \
    apk add --no-cache \
    bash \
    python3 \
    py3-pip \
    build-base \
    libffi-dev \
    openssl-dev \
    git

ENV USERNAME dockeruser
ENV USER_UID 1000
ENV USER_GID 1000

RUN addgroup -g $USER_GID $USERNAME && \
    adduser -D -u $USER_UID -G $USERNAME $USERNAME

WORKDIR /app

COPY . .

RUN chown -R $USERNAME:$USERNAME /app && \
    chmod -R 755 /app

USER $USERNAME

RUN chmod +x install.sh

ENTRYPOINT [ "/bin/bash", "install.sh" ]
