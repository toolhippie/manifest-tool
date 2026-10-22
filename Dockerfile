FROM ghcr.io/dockhippie/alpine:3.23@sha256:b2f0d0b2460a72855e02bbb1c62bd1b6387c70da93984d4c8ea3e85f5dbfd4a8
ENTRYPOINT [""]

# renovate: datasource=github-releases depName=estesp/manifest-tool
ENV MANIFEST_TOOL_VERSION=2.2.2

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
