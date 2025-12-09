FROM ghcr.io/dockhippie/alpine:3.23@sha256:4e6a8cfc8c6550ca615c09eb1d667b3ee884a827a97965a2e9f5e5142dc9e05a
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
