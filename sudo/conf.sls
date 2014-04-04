{% from "sudo/map.jinja" import sudo with context %}


include:
  - sudo


{{ sudo.config }}:
  file:
    - managed
    - template: jinja
    - source: salt://sudo/files/etc/sudoers.jinja
    - user: root
    - group: root
    - mode: 440
    - require:
      - pkg: sudo
