nginx:
  pkg.installed:
    - version: {{ pillar['nginx']['version'] }}
    - hold: True
  service.running:
    - enable: True
    - watch:
      - file: /etc/nginx/sites-enabled/aylien-slim.conf
      - file: /opt/aylien_app

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
    - target: /srv/www/aylien-slim
    - user: www-data
    - group: www-data
    - force: True
    - require:
      - git: first_app_clone

first_app_clone:
  git.latest:
    - name: git@github.com:ptavoularis/aylien-slim.git
    - target: /srv/www/aylien-slim
    - user: www-data
    - require:
      - file: copy_known_hosts
      - file: /srv/www

/srv/www:
  file.directory:
    - user: www-data
    - group: www-data

copy_git_ssh_key:
  file.copy:
    - name: /var/www/.ssh/id_rsa
    - source: /root/.ssh/id_rsa
    - makedirs: True
    - user: www-data
    - group: www-data
    - mode: 0600

copy_known_hosts:
  file.copy:
    - name: /var/www/.ssh/known_hosts
    - source: /root/.ssh/known_hosts
    - user: www-data
    - group: www-data
    - mode: 0644
    - require:
      - file: copy_git_ssh_key
