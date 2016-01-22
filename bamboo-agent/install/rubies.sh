#!/bin/bash

# Install rubies
for version in 2.1.5
do
  CONFIGURE_OPTS="--disable-install-rdoc" MAKE_OPTS="-j8" eatmydata rbenv install $version
  RBENV_VERSION=$version gem update --system
done

# Make latest 2.1.5 default
rbenv global 2.1.5

# Add shims as bamboo build commands
for shim in $RBENV_ROOT/shims/*; do
  shim=$(basename $shim) # Strip path
  bamboo-capability-command $shim
done

# Add ruby versions as capabilities
for version in $RBENV_ROOT/versions/*; do
  version=$(basename $version) # Strip path
  bamboo-capability "Ruby $version" "`RBENV_VERSION=$version ruby -v`"
done
