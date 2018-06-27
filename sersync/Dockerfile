FROM alpine:3.7

LABEL maintainer="wxg10521@126.com"

ENV ROOT_PASSWORD root

RUN apk update \
	&& apk add --no-cache \
	openssh \
	rsync \
	&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
	&& rm -rf /var/cache/apk/* /tmp/*
COPY GNU-Linux-x86/ /usr/local/sersync/
COPY .ssh  /root/.ssh/
COPY rsyncd.conf /etc/
COPY entrypoint.sh /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["entrypoint.sh"]
