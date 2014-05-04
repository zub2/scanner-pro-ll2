#!/bin/bash

# This repacks the original content from a .zip into a .tar.xz because
# Debian doesn't like original archives in zip format.

ORIG_NAME="lff6020_inb_dlx_eng.zip"
ORIG_VERSION="1.0.7d"

# this should use - instead of _ and include the upstream version
REPACKED_BASE_NAME="scanner-pro-ll2"
REPACKED_TOP_DIR="$REPACKED_BASE_NAME-${ORIG_VERSION}"
REPACKED_NAME="${REPACKED_BASE_NAME}_${ORIG_VERSION}.orig.tar.xz"

# re-pack the orignal zip into a tar.xz
# repack_upstream_zip path_to_orig_zip
# creates ./$REPACKED_NAME that would extract into $REPACKED_BASE_NAME-${ORIG_VERSION}
repack_upstream_zip() {
	PATH_TO_ORIG="$1"
	mkdir "$REPACKED_TOP_DIR"
	(
		cd "$REPACKED_TOP_DIR"
		unzip "../$PATH_TO_ORIG/$ORIG_NAME"
	)
	tar cJvf "$PATH_TO_ORIG/$REPACKED_NAME" "$REPACKED_TOP_DIR"
	rm -rf "$REPACKED_TOP_DIR"
}

mkdir repack
(
	cd repack
	repack_upstream_zip ".."
)
rm -rf repack
