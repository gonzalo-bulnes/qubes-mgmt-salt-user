ssh-socket-present:
   file.append:
    - name: /rw/config/rc.local
    - source: salt://split-ssh/client/files/rc.local.d/sock

ssh-socket-discoverable:
   file.append:
    - name: ~user/.bashrc
    - source: salt://split-ssh/client/files/bashrc.d/sock
