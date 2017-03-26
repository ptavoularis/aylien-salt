reload_fpm_on_app_change:
  service.running:
    - name: php7.0-fpm
    - watch:
      - cmd: update_composer

update_composer:
  composer.update:
    - dir: /srv/www/aylien-slim
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