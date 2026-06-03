FROM public.ecr.aws/docker/library/node:22-bookworm-slim

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends tini ca-certificates \
    && npm install -g n8n@2.22.5 \
    && npm cache clean --force \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV N8N_PORT=10000
ENV N8N_LISTEN_ADDRESS=0.0.0.0
ENV N8N_PROTOCOL=https
ENV N8N_PROXY_HOPS=1
ENV GENERIC_TIMEZONE=America/Lima
ENV TZ=America/Lima
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
ENV N8N_RUNNERS_ENABLED=true

USER node
WORKDIR /home/node

EXPOSE 10000

ENTRYPOINT ["tini", "--"]
CMD ["n8n", "start"]