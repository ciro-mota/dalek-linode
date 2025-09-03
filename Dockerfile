# hadolint ignore=DL3006
# hadolint ignore=DL3007
FROM cgr.dev/chainguard/wolfi-base:latest

LABEL org.opencontainers.image.title="dalek-linode"
LABEL org.opencontainers.image.description="Nuke a whole some resources in a Linode account."
LABEL org.opencontainers.image.authors="Ciro Mota <github.com/ciro-mota> (@ciro-mota)"
LABEL org.opencontainers.image.url="https://github.com/ciro-mota/dalek-linode"
LABEL org.opencontainers.image.documentation="https://github.com/ciro-mota/dalek-linode/README.md"
LABEL org.opencontainers.image.source="https://github.com/ciro-mota/dalek-linode"

WORKDIR /home
COPY requirements.txt .
COPY ./scripts /home

ARG LINODE_CLI_TOKEN
ENV LINODE_CLI_TOKEN=$LINODE_CLI_TOKEN

RUN apk add python3=3.13.7-r1 py3.13-pip=25.2-r0 --no-cache \
	&& pip3 install -r requirements.txt --no-cache-dir --root-user-action=ignore \
	&& chmod +x /home/dalek-linode.sh

CMD ["./dalek-linode.sh"]