#!/usr/bin/env bash

luarocks make --local
luarocks pack oauth-jwks-validator
luarocks pack kong-oidc
luarocks pack lua-resty-openidc
luarocks pack lua-resty-jwt

rm -rf ./rocksdir
mkdir ./rocksdir
mv ./*.rock ./rocksdir/

docker build \
   --build-arg "KONG_LICENSE_DATA=$KONG_LICENSE_DATA" \
   --build-arg KONG_BASE="kong:2.8" \
   --build-arg PLUGINS="oauth-jwks-validator" \
   --build-arg ROCKS_DIR="./rocksdir" \
   --tag "kong-jwks" .
