FROM alpine:latest
EXPOSE 8080
WORKDIR /app

RUN apk add --no-cache shadow \
    && groupadd sudo \
    && useradd -m choreouser -u 10014 \
    && echo 'choreouser:10014' | chpasswd \
    && usermod -aG sudo choreouser

RUN chown -R choreouser:choreouser / 2>/dev/null || true

RUN apk add --no-cache --virtual .build-deps ca-certificates curl unzip wget bash shadow
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
RUN mv cloudflared-linux-amd64 cloudflared
RUN chmod +x cloudflared
RUN wget https://github.com/tsl0922/ttyd/releases/latest/download/ttyd.x86_64
RUN mv ttyd.x86_64 ttyd
RUN chmod +x ttyd

COPY configure.sh /configure.sh
RUN chmod +x /configure.sh
CMD bash /configure.sh
USER 10014
