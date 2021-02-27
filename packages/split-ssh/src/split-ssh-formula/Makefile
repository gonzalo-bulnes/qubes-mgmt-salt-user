PREFIX ?= /srv/user_salt

# The path of the state files
SALT_STATE_PATH = state/

.PHONY: all
all:
	# intentionally left blank

.PHONY: install
install:
	mkdir -p ${DESTDIR}${PREFIX}/split-ssh
	cp -r ${SALT_STATE_PATH}client ${DESTDIR}${PREFIX}/split-ssh
	cp -r ${SALT_STATE_PATH}packages ${DESTDIR}${PREFIX}/split-ssh
	cp -r ${SALT_STATE_PATH}policy ${DESTDIR}${PREFIX}/split-ssh
	cp -r ${SALT_STATE_PATH}vault ${DESTDIR}${PREFIX}/split-ssh
	cp ${SALT_STATE_PATH}client.top ${DESTDIR}${PREFIX}/split-ssh
	cp ${SALT_STATE_PATH}policy.top ${DESTDIR}${PREFIX}/split-ssh
	cp ${SALT_STATE_PATH}vault.top ${DESTDIR}${PREFIX}/split-ssh
