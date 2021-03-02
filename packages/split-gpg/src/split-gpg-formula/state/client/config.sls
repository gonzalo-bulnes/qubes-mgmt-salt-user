/rw/config/gpg-split-domain:
  file.managed:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - source: salt://split-gpg/client/files/gpg-split-domain.jinja
    - template: jinja
