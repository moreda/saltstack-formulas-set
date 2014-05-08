{% from "sudo/map.jinja" import sudo with context %}


include:
  - sudo


{% set files_switch = salt['pillar.get']('sudo:files_switch', ['id']) %}


{{ sudo.config }}:
  file:
    - managed
    - template: jinja
    - source:
      {% for grain in files_switch if salt['grains.get'](grain) is defined -%}
      - salt://sudo/files/{{ salt['grains.get'](grain) }}/etc/sudoers.jinja
      {% endfor -%}
      - salt://sudo/files/default/etc/sudoers.jinja
    - user: root
    - group: root
    - mode: 440
    - require:
      - pkg: sudo
