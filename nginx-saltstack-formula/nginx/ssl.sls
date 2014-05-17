{% from "nginx/map.jinja" import nginx with context %}


include:
- nginx
- nginx.conf


{% for site in salt['pillar.get']('nginx:sites', []) %}
{% set site_attr = salt['pillar.get']('nginx:sites:' ~ site) %}
{% if site_attr['ssl'] is defined %}
/etc/ssl/certs/{{ site }}.crt:
  file:
    - managed
    - source: salt://nginx/files/default/etc/ssl/certs/site.crt.jinja
    - template: jinja
    - context:
      site: {{ site }}
    - watch_in:
      - service: nginx


/etc/ssl/private/{{ site }}.key:
  file:
    - managed
    - source: salt://nginx/files/default/etc/ssl/private/site.key.jinja
    - template: jinja
    - context:
      site: {{ site }}
    - watch_in:
      - service: nginx
{% endif %}
{% endfor %}
