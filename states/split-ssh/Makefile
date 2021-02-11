NAME = qubes-mgmt-salt-user-split-ssh
VERSION ?= 0.1.0
RELEASE ?= 1
TMP ?= /tmp/tito/
SOURCE_ARCHIVE_NAME ?= ${NAME}-${VERSION}.tar.gz
SOURCE_ARCHIVE_PATH = ${TMP}
SRPM_PACKAGE_NAME ?= ${NAME}-${VERSION}-${RELEASE}.fc32.src.rpm
SRPM_PACKAGE_PATH = ${TMP}
RPM_PACKAGE_NAME ?= ${NAME}-${VERSION}-${RELEASE}.fc32.noarch.rpm
RPM_PACKAGE_PATH = ${TMP}noarch/
GPG_NAME ?= "Key ID"

define GPG_CMD
	qubes-gpg-client-wrapper
endef

.PHONY: all
all: verify-sources build test sign-source-archive sign-source-package sign-package
	@echo "Packages built successfully in ${TMP}"
	@-tree ${TMP}

.PHONY: verify-sources
verify-sources:
	git tag -v `git describe`

.PHONY: build
build:
	cd src && tito build --rpm --offline && cd -

.PHONY: test
test:
	# not sure yet how to do this

.PHONY: sign-source-archive
sign-source-archive:
	${GPG_CMD} --local-user "${GPG_NAME}" --sign --armor --output ${SOURCE_ARCHIVE_PATH}${SOURCE_ARCHIVE_NAME}.asc --detach ${SOURCE_ARCHIVE_PATH}${SOURCE_ARCHIVE_NAME}

.PHONY: sign-source-package
sign-source-package:
	rpm --resign ${SRPM_PACKAGE_PATH}${SRPM_PACKAGE_NAME}

.PHONY: sign-package
sign-package:
	rpm --resign ${RPM_PACKAGE_PATH}${RPM_PACKAGE_NAME}

.PHONY: clean
clean:
	-rm -r ${TMP}
