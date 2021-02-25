{% for vault in pillar.split-ssh-vaults %}
{{ vault.name }}-present:
  qvm.present:
    - name: {{ vault.name }}
    - template: {{ vault.template }}
    - label: {{ vault.label }}
    - mem: {{ vault.mem }}
    - vcpus: {{ vault.vcpus }}

{{ vault.name }}-has-no-network-access:
  qvm.prefs:
    - name: {{ vault.name }}
    - netvm: none
    - default_dispvm:

{{ vault.name }}-autostarts:
  qvm.prefs:
    - name: {{ vault.name }}
    - autostart: {{ vault.autostart }}
{% endfor %}

