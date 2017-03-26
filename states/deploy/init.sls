reload_services_on_app_change:
  service.running:
    - name: php7.0-fpm
    - watch:
      - composer: /srv/www/aylien-slim
  service.running:
    - name: nginx
    - watch:
      - composer: /srv/www/aylien-slim

/srv/www/aylien-slim:
  composer.update:
    - user: www-data
    - no_dev: True
    - optimize: True
    - require:
      - git: latest_app_version

latest_app_version:
  git.latest:
    - name: git@github.com:ptavoularis/aylien-slim.git
    - target: /srv/www/aylien-slim
    - user: www-data
