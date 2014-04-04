{% from "shorewall/map.jinja" import shorewall with context %}


include:
  - shorewall


{%if salt['grains.get']('os_family') == 'Debian' %}
shorewall_repo:
  pkgrepo:
    - managed
    - ppa: allenta/shorewall
    - require:
      - cmd: shorewall_repo
    - require_in:
      - pkg: shorewall
  cmd:
    - run
    - name: /usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B874217D
    - unless: /usr/bin/apt-key adv --list-key B874217D
    - user: root
{% endif %}
