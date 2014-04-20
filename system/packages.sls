{% from "system/map.jinja" import system with context %}

packages:
  pkg:
    - installed
    - pkgs: {{ salt['pillar.get']('system:packages', []) }}
