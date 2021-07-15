FROM alpine:latest

LABEL "com.github.actions.name"="Purge Cache Cloudflare Zonee"
LABEL "com.github.actions.description"="Purge a zone's cache via the Cloudflare API"
LABEL "com.github.actions.icon"="trash-2"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/Jonakemon/purge-cache-cloudflare-zone"
LABEL "homepage"="https://github.com/Jonakemon/purge-cache-cloudflare-zone"
LABEL "maintainer"="jonakemon"

RUN apk update && apk add openssl curl

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
