#!/bin/sh
set -eu

APP_ENV=$(printf '%s' "${APP_ENV:-}" | tr '[:upper:]' '[:lower:]')
export APP_ENV

if [ "$APP_ENV" = "prod" ]; then
    cp "/app/configs/config.${APP_ENV}" /app/config
fi

exec "$@"
