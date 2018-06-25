FROM alpine:3.7

LABEL maintainer="wxg10521@126.com"

ENV ROOT_PASSWORD root

RUN apk update \
	&& apk add --no-cache \
	openssh \
	ocaml \
	supervisor \
	unison \
	inotify-tools \
	&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
        && sed -i '33 a\StrictHostKeyChecking no' /etc/ssh/ssh_config \
	&& rm -rf /var/cache/apk/* /tmp/*
COPY .ssh  /root/.ssh/
COPY inotify.sh /usr/local/bin/
COPY supervisord.conf /etc/
COPY sync.ini /etc/supervisor.d/
COPY entrypoint.sh /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["entrypoint.sh"]
