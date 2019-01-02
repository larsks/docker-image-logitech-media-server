#!/bin/sh

QEMU_VERSION=v3.1.0-2
QEMU_ARCHS="x86_64 arm aarch64"

TMPDIR=$(mktemp -d -t qemu-static_XXXX)

# Exit immediately if a command exits with a non-zero status
set -e

cleanup () {
    rm -rf "${TMPDIR}"
}

trap cleanup EXIT

for target_arch in ${QEMU_ARCHS}; do
  wget -N -P "${TMPDIR}" "https://github.com/multiarch/qemu-user-static/releases/download/${QEMU_VERSION}/x86_64_qemu-${target_arch}-static.tar.gz"
  tar -xvf "${TMPDIR}/x86_64_qemu-${target_arch}-static.tar.gz"
done