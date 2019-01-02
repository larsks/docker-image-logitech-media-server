#!/bin/sh

DOCKER_REPO=toertel
DOCKER_IMAGE=logitech-media-server
DOCKER_ARCHS="amd64 arm32v7 arm64v8"

# Exit immediately if a command exits with a non-zero status
set -e

for docker_arch in ${DOCKER_ARCHS}; do
  case ${docker_arch} in
    amd64       ) qemu_arch="x86_64" ;;
    arm32v[5-7] ) qemu_arch="arm" ;;
    arm64v8     ) qemu_arch="aarch64" ;;
    *           )
      echo ERROR: Unsupported architecture \'"${docker_arch}"\'
      exit 1
  esac

  # Instantiate templates and fill in variables
  cp Dockerfile.template "Dockerfile.${docker_arch}"
  sed -i "s/__BASEIMAGE_ARCH__/${docker_arch}/g" "Dockerfile.${docker_arch}"
  sed -i "s/__QEMU_ARCH__/${qemu_arch}/g" "Dockerfile.${docker_arch}"

  if [ "${docker_arch}" = 'amd64' ]; then
    # Remove __CROSS_ commands for amd64 (native) builds
    sed -i "/__CROSS_/d" "Dockerfile.${docker_arch}"
  else
    # Activate __CROSS_ commands for cross builds
    sed -i "s/__CROSS_//g" "Dockerfile.${docker_arch}"
  fi

  docker build -f "Dockerfile.${docker_arch}" -t "${DOCKER_REPO}/${DOCKER_IMAGE}:${docker_arch}-latest" .
done