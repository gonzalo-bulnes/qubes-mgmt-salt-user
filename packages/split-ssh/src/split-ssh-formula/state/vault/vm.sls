ssh-vault-present:
  qvm.present:
    - name: ssh-vault
    - template: fedora-32
    - label: black
    - mem: 400
    - vcpus: 2

ssh-vault-has-no-network-access:
  qvm.prefs:
    - name: ssh-vault
    - netvm: none
    - default_dispvm:

ssh-vault-autostarts:
  qvm.prefs:
    - name: ssh-vault
    - autostart: True

