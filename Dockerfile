# hadolint ignore=DL3006
# hadolint ignore=DL3007
FROM cgr.dev/chainguard/wolfi-base:latest

WORKDIR /home
COPY ./scripts /home

ARG LINODE_CLI_TOKEN
ENV LINODE_CLI_TOKEN=$LINODE_CLI_TOKEN

RUN apk add bash=5.2.37-r2 python3=3.13.2-r2 py3.13-pip=25.0.1-r0 --no-cache \
	&& pip3 install linode-cli==5.56.2 --no-cache-dir --root-user-action=ignore --break-system-packages \
	&& chmod +x /home/dalek-linode.sh

ENTRYPOINT ["/bin/bash"]
CMD ["./dalek-linode.sh"]
