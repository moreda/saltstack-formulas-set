{% from "shorewall/map.jinja" import shorewall with context %}

shorewall:
  pkg:
    - installed
    - name: {{ shorewall.pkg }}
  service:
    - running
    - name: {{ shorewall.service }}
    - enable: True
    - require:
      - pkg: shorewall
