qvm-tags-pillar-extension-defined:
  file.managed:
    - name: /srv/salt/_pillar/qvm_tags.py
    - user: root
    - group: root
    - mode: '640'
    - makedirs: True
    - source: salt://qvm-tags-in-pillar/files/qvm_tags.py

qvm-tags-pillar-extension-enabled:
  file.append:
    - name: /etc/salt/minion.d/qubes_ext_pillar.conf
    - source: salt://qvm-tags-in-pillar/files/qubes_ext_pillar.conf
