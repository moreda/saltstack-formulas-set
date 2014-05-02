{% from "mysql/map.jinja" import mysql with context %}


python-mysqldb:
  pkg:
    - installed
    - name: {{ mysql.pkg_python }}
