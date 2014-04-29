{% from "nginx/map.jinja" import nginx with context %}


include:
  - nginx


# This is a state file to configure nginx. As there is a high variety of needs
# I just choose a way to organize the confs. This state file is prone to be
# forked to suit each one needs. Hopefully, as it is, should be enough for most
# needs.


{{ nginx.config }}:
  file:
    - managed
    - template: jinja
    - source:
      - salt://nginx/files/{{ grains['id'] }}/etc/nginx/nginx.conf.jinja
      - salt://nginx/files/default/etc/nginx/nginx.conf.jinja
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx


{% for site in salt['pillar.get']('nginx:sites', []) %}
{% set site_attr = salt['pillar.get']('nginx:sites:' ~ site) %}
/etc/nginx/sites-available/{{ site }}:
  file:
    - managed
    - source:
      - salt://nginx/files/{{ grains['id'] }}/etc/nginx/sites-available/{{ site_attr['template'] }}.jinja
      - salt://nginx/files/default/etc/nginx/sites-available/{{ site_attr['template'] }}.jinja
    - template: jinja
    - context:
        site: {{ site }}
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

/etc/nginx/sites-enabled/{{ site }}:
  file:
    - symlink
    - target: /etc/nginx/sites-available/{{ site }}
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx


{% if site_attr['root'] is defined %}
{{ site_attr['root'] }}:
  file:
    - directory
    - user: {{ site_attr['user'] }}
    - group: {{ site_attr['group'] }}
    - mode: 2755
    - require:
      - user: {{ site_attr['user'] }}
      - group: {{ site_attr['group'] }}
    - require_in:
      - service: nginx
{% endif %}


{% if site_attr['log_dir'] is defined %}
{{ site_attr['log_dir'] }}:
  file:
    - directory
    - user: {{ site_attr['user'] }}
    - group: {{ site_attr['group'] }}
    - mode: 775
    - require:
      - user: {{ site_attr['user'] }}
      - group: {{ site_attr['group'] }}
    - require_in:
      - service: nginx
{% endif %}
{% endfor %}


{% for site in salt['pillar.get']('nginx:disabled_sites',[]) %}
/etc/nginx/sites-enabled/{{ site }}:
  file:
    - absent
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
{% endfor %}


{% for site in salt['pillar.get']('nginx:absent_sites',[]) %}
/etc/nginx/sites-enabled/{{ site }}:
  file:
    - absent
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
/etc/nginx/sites-available/{{ site }}:
  file:
    - absent
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
{% endfor %}
