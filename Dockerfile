FROM alpine:3.9

ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN apk update \
    && apk add --no-cache bash \
    && apk add --no-cache gettext \
    && apk add --no-cache mysql-client

RUN mkdir /sql

ENTRYPOINT ["/entrypoint.sh"]
