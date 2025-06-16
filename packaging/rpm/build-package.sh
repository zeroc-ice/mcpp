#!/bin/bash
set -eux  # Exit on error, print commands

# Define build root directory
RPM_BUILD_ROOT="/workspace/build"

# Ensure necessary directories exist
mkdir -p "$RPM_BUILD_ROOT"/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}

# Copy mcpp spec file
MCPP_SPEC_SRC="/workspace/mcpp/packaging/rpm/mcpp.spec"
MCPP_SPEC_DEST="$RPM_BUILD_ROOT/SPECS/mcpp.spec"

cp "$MCPP_SPEC_SRC" "$MCPP_SPEC_DEST"

# If MCPP_VERSION is set, update the version in the spec file to the given version. Otherwise use MCPP_VERSION from the
# spec file.
if [[ -n "${MCPP_VERSION:-}" ]]; then
    sed -i "s/^Version:.*/Version: $MCPP_VERSION/" "$MCPP_SPEC_DEST"
fi

# Validate BUILD_ARCH
VALID_ARCHS=("x86_64" "i686" "aarch64")
if [[ -z "${BUILD_ARCH:-}" || ! " ${VALID_ARCHS[@]} " =~ " ${BUILD_ARCH} " ]]; then
    echo "Error: BUILD_ARCH is not set or invalid. Use one of: ${VALID_ARCHS[*]}"
    exit 1
fi

# Define common RPM macros
RPM_MACROS=()
RPM_MACROS+=(--define "_topdir $RPM_BUILD_ROOT")
RPM_MACROS+=(--define "vendor ZeroC, Inc.")

if [[ -n "${GIT_TAG:-}" ]]; then
    RPM_MACROS+=(--define "git_tag $GIT_TAG")
fi

# Download sources
cd "$RPM_BUILD_ROOT/SOURCES"
spectool -g "${RPM_MACROS[@]}" "$MCPP_SPEC_DEST" || { echo "Error: Failed to download sources."; exit 1; }

# Build source RPM
rpmbuild -bs "$MCPP_SPEC_DEST" "${RPM_MACROS[@]}" --target="$BUILD_ARCH"

# Build binary RPM
rpmbuild -bb "$MCPP_SPEC_DEST" "${RPM_MACROS[@]}" --target="$BUILD_ARCH"
