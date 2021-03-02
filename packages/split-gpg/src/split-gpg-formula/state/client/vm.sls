{% for client in pillar.get('split-gpg-clients') %}
{{ client.name }}-present:
  qvm.present:
    - name: {{ client.name }}
    - template: {{ client.template }}
    - label: {{ client.label }}
    - mem: {{ client.mem }}
    - vcpus: {{ client.vcpus }}

{{ client.name }}-autostarts:
  qvm.prefs:
    - name: {{ client.name }}
    - autostart: {{ client.autostart }}
{% endfor %}

