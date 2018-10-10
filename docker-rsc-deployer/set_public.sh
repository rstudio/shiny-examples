#!/usr/bin/env bash

set -e

if [[ -z "$API_KEY" ]]; then
    echo "API_KEY environment variable not set."
    exit 1
fi

if [[ $# == 0 ]]; then
    echo "Missing target RSC server argument. (eg https://beta.rstudioconnect.com)"
    exit 1
fi

SERVER="$1"

get_guid() {
  curl -X GET "${SERVER}/__api__/me" -H "authorization: Key ${API_KEY}" | jt guid %
}

get_example_app_ids() {
  local GUID=$(get_guid)
  curl -X GET "${SERVER}/__api__/applications?count=1000&filter=account_id:${GUID}" \
       -H "authorization: Key ${API_KEY}" \
      | jt applications [ name % ] [ id % ] \
      | egrep '^[0-9]{3}' \
      | awk '{print $2}'
}

set_app_public() {
  local SERVER="$1"
  local APP_ID="$2"
  curl -X POST "${SERVER}/__api__/applications/${APP_ID}" \
       -H "authorization: Key ${API_KEY}" \
       -H "content-type: application/json" \
       -d "$(jo id=${APP_ID} access_type=all)"
}
export -f set_app_public

get_example_app_ids | parallel -j5 set_app_public "${SERVER}" {}
