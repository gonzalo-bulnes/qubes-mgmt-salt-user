PREFIX ?= /srv/user_salt

.PHONY: all
all:
	# intentionally left blank

.PHONY: install
install:
	mkdir -p ${DESTDIR}${PREFIX}/split-ssh
	cp -r client ${DESTDIR}${PREFIX}/split-ssh
	cp -r packages ${DESTDIR}${PREFIX}/split-ssh
	cp -r policy ${DESTDIR}${PREFIX}/split-ssh
	cp -r vault ${DESTDIR}${PREFIX}/split-ssh
	cp client.top ${DESTDIR}${PREFIX}/split-ssh
	cp policy.top ${DESTDIR}${PREFIX}/split-ssh
	cp vault.top ${DESTDIR}${PREFIX}/split-ssh
