{% from "nginx/map.jinja" import nginx with context %}

nginx:
  pkg:
    - installed
    - name: {{ nginx.pkg }}
  service:
    - running
    - name: {{ nginx.service }}
    - reload: True
    - enable: True
    - require:
      - pkg: nginx
