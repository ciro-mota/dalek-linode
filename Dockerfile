# hadolint ignore=DL3006
# hadolint ignore=DL3007
FROM linode/cli:latest

LABEL org.opencontainers.image.title="dalek-linode"
LABEL org.opencontainers.image.description="Nuke a whole some resources in a Linode account."
LABEL org.opencontainers.image.authors="Ciro Mota <github.com/ciro-mota> (@ciro-mota)"
LABEL org.opencontainers.image.url="https://github.com/ciro-mota/dalek-linode"
LABEL org.opencontainers.image.documentation="https://github.com/ciro-mota/dalek-linode/README.md"
LABEL org.opencontainers.image.source="https://github.com/ciro-mota/dalek-linode"

WORKDIR /home

COPY ./scripts /home
USER root
RUN chmod +x /home/dalek-linode.sh
USER cli

ENTRYPOINT ["/bin/sh"]
CMD ["/home/dalek-linode.sh"]