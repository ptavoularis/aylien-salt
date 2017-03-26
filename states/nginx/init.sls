nginx:
  pkg.installed:
    - version: {{ pillar['nginx']['version'] }}
    - hold: True
  service.running:
    - enable: True
    - watch:
      - file: /etc/nginx/sites-enabled/aylien-slim.conf

/etc/nginx/sites-available/aylien-slim.conf:
  file.managed:
    - source: salt://nginx/aylien-slim.conf
    - require:
      - file: /opt/aylien_app

/etc/nginx/sites-enabled/aylien-slim.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/aylien-slim.conf
    - force: True
    - require:
      - file: /etc/nginx/sites-available/aylien-slim.conf

/etc/nginx/sites-enabled/default:
  file.absent

/opt/aylien_app:
  file.symlink:
    - target: /root/aylien-slim
    - force: True
    - require:
      - git: first_app_clone

first_app_clone:
  git.latest:
    - name: git@github.com:ptavoularis/aylien-slim.git
    - target: /root/aylien-slim
