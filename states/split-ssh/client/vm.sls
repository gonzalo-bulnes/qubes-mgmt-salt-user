ssh-client-present:
  qvm.present:
    - name: ssh-client
    - template: fedora-32
    - label: blue
    - mem: 400
    - vcpus: 2

