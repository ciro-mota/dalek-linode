FROM alpine:3.20

WORKDIR /home
COPY ./scripts /home

ENV LINODE_CLI_TOKEN=<your-personal-access-token-here>

RUN apk update \
	&& apk add bash=5.2.26-r0 python3=3.12.3-r1 py3-pip=24.0-r2 --no-cache\
	&& pip3 install linode-cli==5.49.1 --no-cache-dir --root-user-action=ignore --break-system-packages \
	&& chmod +x /home/dalek-linode.sh

ENTRYPOINT ["/bin/bash"]
CMD ["./dalek-linode.sh"]
