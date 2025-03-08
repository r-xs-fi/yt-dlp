FROM alpine:latest AS downloader

RUN apk add --no-cache wget \
  && wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
  && chmod +x yt-dlp

FROM alpine:latest

WORKDIR /workspace

ENTRYPOINT ["/usr/bin/yt-dlp"]

RUN apk add --no-cache python3 ffmpeg

COPY --from=downloader /yt-dlp /usr/bin/

# run as unprivileged user
USER 1000:1000
