{% from "mysql/map.jinja" import mysql with context %}


# This included  state is needed for the salt mysql modules to work, so we
# assume that we always want it
include:
  - mysql.python


mysql-server:
  pkg:
    - installed
    - name: {{ mysql.pkg_server }}
  service:
    - running
    - name: {{ mysql.service_server }}
    - enable: True
    - require:
      - pkg: mysql-server
