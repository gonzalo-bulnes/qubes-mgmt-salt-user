/rw/config/split-ssh/ssh-add.desktop:
  file.managed:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - source: salt://split-ssh/vault/files/ssh-add.desktop

ssh-agent-autostart-present:
  file.append:
    - name: /rw/config/rc.local
    - source: salt://split-ssh/vault/files/rc.local.d/config
