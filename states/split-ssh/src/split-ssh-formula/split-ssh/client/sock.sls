ssh-socket-present:
   file.append:
    - name: /rw/config/rc.local
    - source: salt://split-ssh/client/files/rc.local.d/sock.jinja
    - template: jinja

ssh-socket-discoverable:
   file.append:
    - name: ~user/.bashrc
    - source: salt://split-ssh/client/files/bashrc.d/sock.jinja
    - template: jinja

