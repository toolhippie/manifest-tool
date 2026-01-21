FROM ghcr.io/dockhippie/alpine:3.23@sha256:dd0a8a957cb409bde4a96e04af7b59b16f3436817784c67afb9b6bc431672e3e
ENTRYPOINT [""]

# renovate: datasource=github-releases depName=estesp/manifest-tool
ENV MANIFEST_TOOL_VERSION=2.2.1

ARG TARGETARCH

RUN apk update && \
  apk upgrade && \
  curl -sSLo- https://github.com/estesp/manifest-tool/releases/download/v${MANIFEST_TOOL_VERSION}/binaries-manifest-tool-${MANIFEST_TOOL_VERSION}.tar.gz | tar -xvzf - -C /tmp && \
  case "${TARGETARCH}" in \
    'amd64') \
      cp /tmp/manifest-tool-linux-amd64 /usr/bin/manifest-tool; \
      ;; \
    'arm64') \
      cp /tmp/manifest-tool-linux-arm64 /usr/bin/manifest-tool; \
      ;; \
    'arm') \
      cp /tmp/manifest-tool-linux-armv6 /usr/bin/manifest-tool; \
      ;; \
    *) echo >&2 "error: unsupported architecture '${TARGETARCH}'"; exit 1 ;; \
  esac && \
  rm -f /tmp/manifest-tool* && \
  chmod 755 /usr/bin/manifest-tool && \
  rm -rf /var/cache/apk/*
