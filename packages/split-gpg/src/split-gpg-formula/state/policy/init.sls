gpg-vault-policy-present:
  file.prepend:
    - name: /etc/qubes-rpc/policy/qubes.Gpg
    - source: salt://split-gpg/policy/files/qubes.Gpg.d/vault.jinja
    - template: jinja
