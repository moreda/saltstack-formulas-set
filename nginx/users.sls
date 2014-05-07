{% from "nginx/map.jinja" import nginx with context %}


nginx_user:
  user:
    - present
    - name: {{ salt['pillar.get']('nginx:user', 'www-data') }}


nginx_group:
  group:
    - present
    - name: {{ salt['pillar.get']('nginx:group', 'www-data') }}
