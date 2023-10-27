FROM alpine

WORKDIR /home
COPY ./scripts /home

ENV LINODE_CLI_TOKEN=<your-personal-access-token-here>

RUN apk update \
	&& apk add bash python3 py3-pip \
	&& pip3 install linode-cli --root-user-action=ignore \
	&& apk cache clean \
	&& chmod +x /home/dalek-linode.sh

CMD ["./dalek-linode.sh"]