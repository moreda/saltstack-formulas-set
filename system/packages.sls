{% from "system/map.jinja" import system with context %}

{% if salt['pillar.get']('system:packages') is defined %}
packages:
  pkg:
    - installed
    - pkgs: {{ salt['pillar.get']('system:packages') }}
{% endif %}
