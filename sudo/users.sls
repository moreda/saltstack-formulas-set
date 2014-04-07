{% from "sudo/map.jinja" import sudo with context %}


sudo_group:
  group:
    - present
    - name: sudo
