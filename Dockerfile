FROM ghcr.io/dockhippie/alpine:3.23@sha256:a674aadc1cccd2f424673c7596eff46336210016a50c8082849071f78bb15105
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
