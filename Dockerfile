FROM amazonlinux:latest
WORKDIR /home/choreouser
COPY . /home/choreouser/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN yum update
RUN yum install shadow-utils nano tar wget procps sudo pip -y
RUN pip install supervisor
RUN groupadd sudo \
    && useradd -m choreouser -u 10014 \
    && echo 'choreouser:10014' | chpasswd \
    && usermod -aG sudo choreouser
RUN chown -R choreouser:choreouser / 2>/dev/null || true

RUN wget https://github.com/BrahyMasterx/X2mod/raw/main/cloudflared &&\
mv cloudflared cfrd &&\
wget https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 &&\
mv ttyd.x86_64 ttyd &&\
wget https://github.com/BrahyMasterx/X2mod/raw/main/web.js &&\
mv web.js web2.js &&\
chmod 777 ttyd cfrd web2.js &&\
wget https://github.com/filebrowser/filebrowser/releases/download/v2.23.0/linux-amd64-filebrowser.tar.gz &&\
tar -xf linux-amd64-filebrowser.tar.gz &&\
rm -rf linux-amd64-filebrowser.tar.gz

CMD ["./cfrd tunnel --edge-ip-version auto --no-autoupdate --loglevel panic --metrics 0.0.0.0:3001 --protocol http2 run --token eyJhIjoiYWQ1NDUwYTgyNTI0M2VhZTE5Y2E0ODI4MWQxNTRiZjIiLCJ0IjoiMmQwYjY5MDctNDBiZS00N2MyLThjZGYtMGMyYzAxYzIwN2JlIiwicyI6Ik9UUm1PREZsWW1JdE5EZGtPUzAwWVRaakxXSTFNRGt0WVRoaVl6STNZVE01WXpKaiJ9 & ./index2 run -c /home/choreouser/config1.yaml"]
USER 10014
