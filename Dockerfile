# The version of Alpine to use for the final image
# This should match the version of Alpine that the `elixir:1.7.2-alpine` image uses
ARG ALPINE_VERSION=3.9

FROM elixir:1.8.1-alpine AS builder
ARG APP_NAME=postit
# The version of the application we are building (required)
ARG APP_VSN=0.1.0
ARG phoenix_subdir=.
ARG DB_PASSWORD
ARG DB_NAME_BETA
ARG DB_SOCKET_DIR_BETA
ARG DB_USERNAME
ARG SECRET_KEY_BASE
ARG AUTH0_DOMAIN
ARG AUTH0_CLIENT_ID
ARG AUTH0_CLIENT_SECRET
ENV PORT=8080 MIX_ENV=prod REPLACE_OS_VARS=true TERM=xterm
# Passing in db info at compile time using `--build-arg` with `docker build`
ENV DB_USERNAME=${DB_USERNAME} \
  DB_PASSWORD=${DB_PASSWORD} \
  DB_NAME_BETA=${DB_NAME_BETA} \
  DB_SOCKET_DIR_BETA=${DB_SOCKET_DIR_BETA} \
  SECRET_KEY_BASE=${SECRET_KEY_BASE} \
  AUTH0_DOMAIN=${AUTH0_DOMAIN} \
  AUTH0_CLIENT_ID=${AUTH0_CLIENT_ID} \
  AUTH0_CLIENT_SECRET=${AUTH0_CLIENT_SECRET} \
  APP_VSN=${APP_VSN} 

WORKDIR /opt/app
RUN printenv
RUN apk update \
  && apk --update add nodejs nodejs-npm \
  && mix local.rebar --force \
  && mix local.hex --force
COPY . .
RUN mix do deps.get, deps.compile, compile
RUN cd ${phoenix_subdir}/assets \
  && npm install \
  && ./node_modules/webpack/bin/webpack.js --mode production \
  && cd .. \
  && mix phx.digest


RUN \
  mkdir -p /opt/built && \
  mix release --verbose && \
  cp _build/${MIX_ENV}/rel/${APP_NAME}/releases/${APP_VSN}/${APP_NAME}.tar.gz /opt/built && \
  cd /opt/built && \
  tar -xzf ${APP_NAME}.tar.gz && \
  rm ${APP_NAME}.tar.gz
## It's important to have matching apline
# From this line onwards, we're in a new image, which will be the image used in production
FROM alpine:${ALPINE_VERSION}
ARG project_id
ENV GCLOUD_PROJECT_ID=${project_id}
RUN mkdir -p /usr/local/bin \
  && wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 \
  -O /usr/local/bin/cloud_sql_proxy \
  && chmod +x /usr/local/bin/cloud_sql_proxy \
  && mkdir -p /tmp/cloudsql

# The name of your application/release (required)
ARG APP_NAME=postit

ENV PORT=8080 \
  REPLACE_OS_VARS=true \
  APP_NAME=${APP_NAME}

WORKDIR /opt/app

COPY --from=builder /opt/built .

CMD trap 'exit' INT;  /opt/app/bin/${APP_NAME} foreground 
