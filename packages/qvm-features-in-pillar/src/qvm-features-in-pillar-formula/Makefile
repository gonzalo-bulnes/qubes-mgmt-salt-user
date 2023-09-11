PREFIX ?= /srv/user_salt

# The path of the state files
SALT_STATE_PATH = state/

.PHONY: all
all:
	# intentionally left blank

.PHONY: install
install: state

.PHONY: state
state:
	mkdir -p ${DESTDIR}${PREFIX}/qvm-features-in-pillar
	cp -rT ${SALT_STATE_PATH} ${DESTDIR}${PREFIX}/qvm-features-in-pillar
