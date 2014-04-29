{% from "php5/map.jinja" import php5 with context %}


include:
  - php5.fpm


{% for pool in salt['pillar.get']('php5-fpm:pools', []) %}
{% set pool_attr = salt['pillar.get']('php5-fpm:pools:' ~ pool) %}
/etc/php5/fpm/pool.d/{{ pool }}.conf:
  file:
    - managed
    - source:
      - salt://php5/files/{{ grains['id'] }}/etc/php5/fpm/pool.d/www.conf.jinja
      - salt://php5/files/default/etc/php5/fpm/pool.d/www.conf.jinja
    - template: jinja
    - context:
        pool: {{ pool }}
    - require:
      - pkg: php5-fpm
      - user: {{ pool_attr['user'] }}
      - group: {{ pool_attr['group'] }}
    - watch_in:
      - service: php5-fpm
{% endfor %}


{% for pool in salt['pillar.get']('php5-fpm:absent_pools', []) %}
/etc/php5/fpm/pool.d/{{ pool }}.conf:
  file:
    - absent
    - require:
      - pkg: php5-fpm
    - watch_in:
      - service: php5-fpm
{% endfor %}
