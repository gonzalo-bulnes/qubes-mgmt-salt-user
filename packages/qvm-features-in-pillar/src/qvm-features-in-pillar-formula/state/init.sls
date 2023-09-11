qvm-features-pillar-extension-defined:
  file.managed:
    - name: /srv/salt/_pillar/qvm_features.py
    - user: root
    - group: root
    - mode: '640'
    - makedirs: True
    - source: salt://qvm-features-in-pillar/files/qvm_features.py

qvm-features-pillar-extension-enabled:
  file.append:
    - name: /etc/salt/minion.d/qubes_ext_pillar.conf
    - source: salt://qvm-features-in-pillar/files/qubes_ext_pillar.conf
