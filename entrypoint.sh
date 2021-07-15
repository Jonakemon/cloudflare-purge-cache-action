#!/bin/sh

set -e

if [ -z "$INPUT_CLOUDFLAREZONE" ]; then
  echo "cloudflareZone is not set. Quitting."
  exit 1
fi

if [ -z "$INPUT_CLOUDFLAREAPIKEY" ]; then
  echo "cloudflareApiKey is not set. Quitting."
  exit 1
fi

# Call the API and store the response for later.
HTTP_RESPONSE=$(curl -i -o - --silent -X POST "https://api.cloudflare.com/client/v4/zones/${INPUT_CLOUDFLAREZONE}/purge_cache" \
                     --data '{"purge_everything":true}' \
                     -H "Authorization: Bearer ${INPUT_CLOUDFLAREAPIKEY}")

# Store result and HTTP status code separately to appropriately throw CI errors.
# https://gist.github.com/maxcnunes/9f77afdc32df354883df
HTTP_BODY=$(echo "${HTTP_RESPONSE}" | sed -E 's/HTTP_STATUS\:[0-9]{3}$//')
HTTP_STATUS=$(echo "${HTTP_RESPONSE}" | grep HTTP |  awk '{print $2}')

# Fail pipeline and print errors if API doesn't return an OK status.
if [ "${HTTP_STATUS}" -eq "200" ]; then
  echo "Successfully purged!"
  exit 0
else
  echo "Purge failed. API response was: "
  echo $HTTP_BODY
  exit 1
fi
