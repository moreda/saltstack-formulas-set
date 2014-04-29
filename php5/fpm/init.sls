{% from "php5/map.jinja" import php5 with context %}


php5-fpm:
  pkg:
    - installed
    - name: {{ php5.pkg_fpm }}
  service:
    - running
    - enable: True
    - require:
      - pkg: php5-fpm
