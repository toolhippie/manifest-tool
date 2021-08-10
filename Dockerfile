FROM webhippie/alpine:latest
ENTRYPOINT [""]

# renovate: datasource=github-releases depName=estesp/manifest-tool
ENV MANIFEST_TOOL_VERSION=1.0.3

ARG TARGETARCH=amd64

RUN apk update && \
  apk upgrade && \
  case "${TARGETARCH}" in \
		'amd64') \
			wget -qO /usr/bin/manifest-tool https://github.com/estesp/manifest-tool/releases/download/v${MANIFEST_TOOL_VERSION}/manifest-tool-linux-amd64; \
			;; \
		'arm64') \
			wget -qO /usr/bin/manifest-tool https://github.com/estesp/manifest-tool/releases/download/v${MANIFEST_TOOL_VERSION}/manifest-tool-linux-arm64; \
			;; \
		'arm') \
			wget -qO /usr/bin/manifest-tool https://github.com/estesp/manifest-tool/releases/download/v${MANIFEST_TOOL_VERSION}/manifest-tool-linux-armv6; \
			;; \
		*) echo >&2 "error: unsupported architecture '${TARGETARCH}'"; exit 1 ;; \
	esac && \
  chmod +x /usr/bin/manifest-tool && \
  rm -rf /var/cache/apk/*
