#!/usr/bin/bash

formula=split-ssh
echo "Which formula do you want to release? e.g. split-ssh"
read -r formula
export FORMULA=$formula
echo FORMULA="$FORMULA"

version=0.0.0
echo "What is the version number? e.g. 1.2.3"
read -r version
export VERSION=$version
echo VERSION="$VERSION"

release=0
echo "What is the release number? e.g. 4"
echo "The release number is how many times a given version has been released."
read -r release
export RELEASE=$release
echo RELEASE="$RELEASE"

printf "Creating the release artifacts..."
make release
echo " DONE"

keyid="Packaging"
read -r keyid
export GPG_NAME=$keyid
echo GPG_NAME="$GPG_NAME"

printf "Creating release commit..."
git commit -m "Release ${FORMULA}-${VERSION}-${RELEASE}"
echo " DONE"
echo "Created tag: ${FORMULA}-${VERSION}-${RELEASE}"

printf "Creating Git tag to be used by Tito..."
git tag qubes-mgmt-salt-user-${FORMULA}-${VERSION}-${RELEASE}
echo " DONE"
echo "Created tag: qubes-mgmt-salt-user-${FORMULA}-${VERSION}-${RELEASE}"

printf "Creating signed tag..."
git stag
echo " DONE"

printf "Creating the packages..."
make packages
echo " DONE"

echo "The packages were created in /tmp/tito:"
tree /tmp/tito

printf "Unsetting environment variables..."
unset FORMULA
unset VERSION
unset RELEASE
unset GPG_NAME
echo " DONE"