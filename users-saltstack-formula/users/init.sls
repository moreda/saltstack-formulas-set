{% from "users/map.jinja" import users with context %}


# Create users conforming to pillar.
{% for user in pillar['users']| d({}) %}
{% set user_attrs = pillar['users'][user] %}
{{ user }}:
  user:
    - present
    - name: {{ user }}
    - home: {{ user_attrs['home']| d('/home/' ~ user) }}
    - createhome: {{ user_attrs['createhome']| d('True') }}
    - fullname: {{ user_attrs['fullname']| d('') }}
    - password: {{ user_attrs['password']| d('!') }}
    - shell: {{ user_attrs['shell']| d('/bin/bash') }}
    {% if user_attrs['creategroup'] is defined and user_attrs['creategroup'] %}
    - gid_from_name: True
    {% endif %}
    {% if user_attrs['groups'] is defined %}
    - groups: {{ user_attrs['groups'] }}
    - require:
      {% for group in user_attrs['groups'] %}
      - group: {{ group }}
      {% endfor %}
    {% endif %}
  # Create ssh auth keys for each user.
  {% if user_attrs['ssh_auth'] is defined %}
  ssh_auth:
    - present
    - names: {{ user_attrs['ssh_auth'] }}
    - user: {{ user }}
    - require:
      - user: {{ user }}
  {% endif %}
  {% if user_attrs['creategroup'] is defined and user_attrs['creategroup'] %}
  group:
    - present
    - require_in:
      - user: {{ user }}
  {% endif %}
{% endfor %}


# Support for absent users.
{% for user in salt['pillar.get']('absent_users', []) %}
{{ user }}:
  user:
    - absent
    - name: {{ user }}
{% endfor %}


# Create groups.
{% for group in salt['pillar.get']('groups', []) %}
{{ group }}:
  group:
    - present
    - name: {{ group }}
{% endfor %}


# Create system groups.
{% for group in salt['pillar.get']('system_groups', []) %}
{{ group }}:
  group:
    - present
    - name: {{ group }}
    - system: True
{% endfor %}
