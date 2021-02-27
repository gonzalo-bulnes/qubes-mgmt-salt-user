PREFIX ?= /srv/user_salt

# Assumes layout but allows modification of PREFIX
PILLAR_PREFIX ?= ${PREFIX}/../user_pillar

# The path of the state files
SALT_STATE_PATH = state/

# The path of the pillar files
SALT_PILLAR_PATH = pillar/

.PHONY: all
all:
	# intentionally left blank

.PHONY: install
install: pillar state

.PHONY: pillar
pillar:
	mkdir -p ${DESTDIR}${PILLAR_PREFIX}/split-ssh
	cp ${SALT_PILLAR_PATH}clients.sls ${DESTDIR}${PILLAR_PREFIX}/split-ssh
	cp ${SALT_PILLAR_PATH}config.yaml ${DESTDIR}${PILLAR_PREFIX}/split-ssh
	cp ${SALT_PILLAR_PATH}init.jinja ${DESTDIR}${PILLAR_PREFIX}/split-ssh
	cp ${SALT_PILLAR_PATH}vaults.sls ${DESTDIR}${PILLAR_PREFIX}/split-ssh

.PHONY: state
state:
	mkdir -p ${DESTDIR}${PREFIX}/split-ssh
	cp -r ${SALT_STATE_PATH}client ${DESTDIR}${PREFIX}/split-ssh
	cp -r ${SALT_STATE_PATH}packages ${DESTDIR}${PREFIX}/split-ssh
	cp -r ${SALT_STATE_PATH}policy ${DESTDIR}${PREFIX}/split-ssh
	cp -r ${SALT_STATE_PATH}vault ${DESTDIR}${PREFIX}/split-ssh
	cp ${SALT_STATE_PATH}client.top ${DESTDIR}${PREFIX}/split-ssh
	cp ${SALT_STATE_PATH}policy.top ${DESTDIR}${PREFIX}/split-ssh
	cp ${SALT_STATE_PATH}vault.top ${DESTDIR}${PREFIX}/split-ssh
