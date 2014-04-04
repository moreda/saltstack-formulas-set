{% from "shorewall/map.jinja" import shorewall with context %}


include:
  - shorewall


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
      - salt://shorewall/files/{{ grains['id'] }}/etc/shorewall/shorewall.conf.jinja
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
      - salt://shorewall/files/{{ grains['id'] }}/etc/shorewall/{{ conf }}.jinja
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
