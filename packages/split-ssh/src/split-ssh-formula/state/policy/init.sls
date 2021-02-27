/etc/qubes-rpc/policy/qubes.SSHAgent:
  file.managed:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - source: salt://split-ssh/policy/files/qubes.SSHAgent
    - template: jinja

