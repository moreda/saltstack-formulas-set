{% from "sudo/map.jinja" import sudo with context %}

sudo:
  pkg:
    - installed
    - name: {{ sudo.pkg }}
