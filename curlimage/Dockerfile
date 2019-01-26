
FROM alpine:3.8

RUN apk add --update curl && rm -rf /var/cache/apk/*

ADD bootstrap.sh /
RUN chmod a+x /bootstrap.sh

ENTRYPOINT ["sh", "-c"]

