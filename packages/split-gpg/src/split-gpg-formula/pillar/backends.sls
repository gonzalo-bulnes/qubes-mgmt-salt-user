## Load config
#{% load_yaml as config %}
#{% include 'split-gpg/config.yaml' %}
#{% endload %}
---
split-gpg-backends:
  {{ config.backends }}
