# hadolint ignore=DL3006
# hadolint ignore=DL3007
FROM cgr.dev/chainguard/wolfi-base:latest

LABEL org.opencontainers.image.title="dalek-linode"
LABEL org.opencontainers.image.description="Nuke a whole some resources in a Linode account. "
LABEL org.opencontainers.image.authors="Ciro Mota <github.com/ciro-mota> (@ciro-mota)"
LABEL org.opencontainers.image.url="https://github.com/${REPO_OWNER}/${REPO_NAME}"
LABEL org.opencontainers.image.documentation="https://github.com/${REPO_OWNER}/${REPO_NAME}#README"
LABEL org.opencontainers.image.source="https://github.com/${REPO_OWNER}/${REPO_NAME}"

WORKDIR /home
COPY ./scripts /home

ARG LINODE_CLI_TOKEN
ENV LINODE_CLI_TOKEN=$LINODE_CLI_TOKEN

RUN apk add bash=5.2.37-r33 python3=3.13.5-r0 py3.13-pip=25.1.1-r2 --no-cache \
	&& pip3 install linode-cli==5.59.0 --no-cache-dir --root-user-action=ignore --break-system-packages \
	&& chmod +x /home/dalek-linode.sh

ENTRYPOINT ["/bin/bash"]
CMD ["./dalek-linode.sh"]