{% for backend in pillar.get('split-gpg-backends') %}
{{ backend.name }}-present:
  qvm.present:
    - name: {{ backend.name }}
    - template: {{ backend.template }}
    - label: {{ backend.label }}
    - mem: {{ backend.mem }}
    - vcpus: {{ backend.vcpus }}

{{ backend.name }}-has-no-network-access:
  qvm.prefs:
    - name: {{ backend.name }}
    - netvm: none
    - default_dispvm:

{{ backend.name }}-autostarts:
  qvm.prefs:
    - name: {{ backend.name }}
    - autostart: {{ backend.autostart }}
{% endfor %}
