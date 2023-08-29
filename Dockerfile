FROM amazonlinux:latest
EXPOSE 7860
WORKDIR /app
COPY . /app
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN yum update
RUN yum install shadow-utils nano tar wget procps sudo pip -y
RUN groupadd sudo \
    && useradd -m choreouser -u 10014 \
    && echo 'choreouser:10014' | chpasswd \
    && usermod -aG sudo choreouser
RUN chown -R choreouser:choreouser / 2>/dev/null || true
RUN pip install supervisor

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

CMD ["supervisord"]
USER 10014
