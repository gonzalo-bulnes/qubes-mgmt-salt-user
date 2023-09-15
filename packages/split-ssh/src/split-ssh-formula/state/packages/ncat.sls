ncat:
  {%- if grains.get('os') == 'Fedora' %}
  pkg.installed:
    - name: nmap-ncat
  {%- else %}
  pkg.installed:
    - name: ncat
  {%- endif %}
