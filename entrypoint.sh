#!/bin/sh
set -e

while [ ! -x /sources/build.sh ]
do
    sleep 30
done

# Update APT cache
/usr/lib/docker-helpers/apt-setup

# Install build dependencies if package is specified
if [ -n "${PACKAGE}" ]
then
    echo "Install build dependencies for ${PACKAGE}..."
    apt-get --assume-yes build-dep "${PACKAGE}"
fi

# Change ownership of the artifacts directory
chown -R build /artifacts

# Execute the build (as user 'build')
gosu build /sources/build.sh

# Cleanup APT caches
/usr/lib/docker-helpers/apt-cleanup
