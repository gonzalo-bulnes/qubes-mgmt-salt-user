## Load config
#{% load_yaml as config %}
#{% include 'split-ssh/config.yaml' %}
#{% endload %}
---
split-ssh-clients:
  {{ config.clients }}

