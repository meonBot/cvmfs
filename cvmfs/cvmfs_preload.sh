#!/bin/bash
export TMPDIR=`mktemp -d /tmp/cvmfs_preload_selfextracted.XXXXXX`

ARCHIVE=`awk '/^__ARCHIVE_BELOW__/ {print NR + 1; exit 0; }' $0`

tail -n+"$ARCHIVE" "$0" | tar xz -C "$TMPDIR" || echo "Couldn't extract the tar file"

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$TMPDIR"

# execute the command
$TMPDIR/cvmfs_preload $@ || echo "Failed to execute cvmfs_preload"

rm -rf "$TMPDIR"

exit 0

__ARCHIVE_BELOW__
