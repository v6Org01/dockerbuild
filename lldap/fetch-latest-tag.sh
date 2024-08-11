#!/bin/bash

# Define your repository
REPO="lldap/lldap"

# Function to fetch tags with pagination
fetch_tags() {
    local PAGE=$1
    curl -s "https://registry.hub.docker.com/v2/repositories/$REPO/tags?page_size=100&page=$PAGE"
}

# Initialize variables
PAGE=1
DATE_REGEX='^[0-9]{4}-[0-9]{2}-[0-9]{2}-alpine-rootless$'
LATEST_TAG=""
LATEST_DATE="0000-00-00"

# Loop to handle pagination
while : ; do
    TAGS=$(fetch_tags $PAGE)

    # Extract and process tags that match the required format
    MATCHING_TAGS=$(echo $TAGS | jq -r '.results[].name' | grep -E "$DATE_REGEX")
    
    for TAG in $MATCHING_TAGS; do
        TAG_DATE=$(echo $TAG | cut -d'-' -f1-3)
        
        if [[ "$TAG_DATE" > "$LATEST_DATE" ]]; then
            LATEST_DATE=$TAG_DATE
            LATEST_TAG=$TAG
        fi
    done

    # Check if there are more pages
    NEXT_PAGE=$(echo $TAGS | jq -r '.next')
    if [ "$NEXT_PAGE" == "null" ]; then
        break
    fi

    # Increment the page number
    PAGE=$((PAGE + 1))
done

# Check if a tag was found
if [ -z "$LATEST_TAG" ]; then
    echo "No tags found matching the format YYYY-MM-DD-alpine-rootless"
    exit 1
fi

# Output the pulled tag
echo "Pulled the latest image from Dockerhub with tag: $LATEST_TAG"

# Update Github Actions vars

if [ "$LATEST_TAG" != "$LLDAP_LATEST_IMAGE" ]; then
  echo "New image found with tag: $LATEST_TAG"

  curl -L \
    -X PATCH \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GITHUB_PAT" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/elaurensx/dockerbuild/actions/variables/LLDAP_NEW_IMAGE_FOUND \
    -d "{\"name\":\"LLDAP_NEW_IMAGE_FOUND\",\"value\":\"true\"}"

  curl -L \
    -X PATCH \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GITHUB_PAT" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/elaurensx/dockerbuild/actions/variables/LLDAP_IMAGE_LATEST \
    -d "{\"name\":\"LLDAP_IMAGE_LATEST\",\"value\":\"$LATEST_TAG\"}"

  se
  echo "No new image found."

  curl -L \
    -X PATCH \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GITHUB_PAT" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/elaurensx/dockerbuild/actions/variables/LLDAP_NEW_IMAGE_FOUND \
    -d "{\"name\":\"LLDAP_NEW_IMAGE_FOUND\",\"value\":\"false\"}"
