nginx:
  pkg.installed:
    - version: {{ pillar['nginx']['version'] }}
    - hold: True
  service.running:
    - enable: True
    - watch:
      - file: /etc/nginx/sites-available/aylien-slim.conf

/etc/nginx/sites-available/aylien-slim.conf:
  file.managed:
    - source: salt://nginx/aylien-slim.conf

/etc/nginx/sites-enabled/aylien-slim.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/aylien-slim.conf
    - force: True
    - require:
      - file: /etc/nginx/sites-available/aylien-slim.conf
