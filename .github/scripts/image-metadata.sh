#!/usr/bin/env bash
set -euo pipefail

: "${GH_TOKEN:?GH_TOKEN is required}"
: "${REGISTRY_USER:?REGISTRY_USER is required}"
: "${IMAGE_NAME:?IMAGE_NAME is required}"
: "${FEDORA_VERSION:?FEDORA_VERSION is required}"
: "${GITHUB_REPOSITORY_OWNER:?}"
: "${GITHUB_SHA:?}"
: "${GITHUB_OUTPUT:?}"

OWNER="${GITHUB_REPOSITORY_OWNER,,}"
IMAGE="ghcr.io/${OWNER}/${IMAGE_NAME}"
SHA_TAG="${GITHUB_SHA:0:7}"

printf '%s' "$GH_TOKEN" |
  crane auth login ghcr.io \
    --username "$REGISTRY_USER" \
    --password-stdin

SOURCE_TAG="$(
  crane ls "$IMAGE" |
    awk -v prefix="${SHA_TAG}-${FEDORA_VERSION}-" '
      index($0, prefix) == 1 {
        suffix = substr($0, length(prefix) + 1)
        if (length(suffix) == 8 && suffix ~ /^[0-9]+$/) {
          print
        }
      }
    ' |
    LC_ALL=C sort |
    tail -n 1
)"

if [[ -z "$SOURCE_TAG" ]]; then
  echo "::error::No tag matching ${SHA_TAG}-${FEDORA_VERSION}-YYYYMMDD found in ${IMAGE}"
  exit 1
fi

DATE_TAG="${SOURCE_TAG##*-}"

{
  printf 'source_tag=%s\n' "$SOURCE_TAG"
  printf 'short_sha=%s\n' "$SHA_TAG"
  printf 'build_date=%s\n' "$DATE_TAG"
} >> "$GITHUB_OUTPUT"

echo "Source image: ${IMAGE}:${SOURCE_TAG}"
