# syntax=docker/dockerfile:1.7

FROM php:8.5.12-cli-alpine3.24

WORKDIR /app
COPY src/index.php ./
COPY src/config.prod src/config.dev ./configs/
COPY --chmod=0555 docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chown www-data:www-data /app

ENV APP_ENV=prod

EXPOSE 8080
USER www-data

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/app"]
