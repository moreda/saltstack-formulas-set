{% from "shorewall/map.jinja" import shorewall with context %}


include:
  - shorewall


{% set files_switch = salt['pillar.get']('shorewall:files_switch', ['id']) %}


extend:
  shorewall:
    service:
      - require:
        - file: {{ shorewall.config }}
{%- if grains['os_family'] == 'Debian' %}
        - file: /etc/default/shorewall
{%- endif %}


{%- if grains['os_family'] == 'Debian' %}
/etc/default/shorewall:
  file:
    - sed
    - before: 0
    - after: 1
    - limit: ^startup=
    - require:
      - pkg: shorewall
{% endif %}


{{ shorewall.config }}:
  file:
    - managed
    - source:
      {% for grain in files_switch if salt['grains.get'](grain) is defined -%}
      - salt://shorewall/files/{{ salt['grains.get'](grain) }}/etc/shorewall/shorewall.conf.jinja
      {% endfor -%}
      - salt://shorewall/files/default/etc/shorewall/shorewall.conf.jinja
    - template: jinja
    - watch_in:
      - service: shorewall
    - require:
      - pkg: shorewall


{% for conf in salt['pillar.get']('shorewall:confs', []) %}
/etc/shorewall/{{ conf }}:
  file:
    - managed
    - source:
      {% for grain in files_switch if salt['grains.get'](grain) is defined -%}
      - salt://shorewall/files/{{ salt['grains.get'](grain) }}/etc/shorewall/{{ conf }}.jinja
      {% endfor -%}
      - salt://shorewall/files/default/etc/shorewall/{{ conf }}.jinja
    - template: jinja
    - watch_in:
      - service: shorewall
    - require:
      - pkg: shorewall
{% endfor %}


{% for conf in salt['pillar.get']('shorewall:confs_absent', []) %}
/etc/shorewall/{{ conf }}:
  file:
    - absent
    - watch_in:
      - service: shorewall
    - require:
      - pkg: shorewall
{% endfor %}
