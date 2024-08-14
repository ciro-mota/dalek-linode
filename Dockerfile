# hadolint ignore=DL3006
# hadolint ignore=DL3007
FROM cgr.dev/chainguard/wolfi-base:latest

WORKDIR /home
COPY ./scripts /home

ENV LINODE_CLI_TOKEN=<your-personal-access-token-here>

RUN apk add bash=5.2.32-r2 python3=3.12.3-r1 py3.12-pip=24.2-r1 --no-cache \
	&& pip3 install linode-cli==5.51.0 --no-cache-dir --root-user-action=ignore --break-system-packages \
	&& chmod +x /home/dalek-linode.sh

ENTRYPOINT ["/bin/bash"]
CMD ["./dalek-linode.sh"]
