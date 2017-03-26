php7:
  pkg.installed:
    - pkgs:
      - php
      - php-cli
      - php-fpm
    - version: {{ pillar['php']['version'] }}
    - hold: True

install_composer:
  cmd.run:
    - name: 'export COMPOSER_HOME=/usr/local/bin && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer'
    - unless: ls /usr/local/bin/composer
    - require:
      - pkg: php7

php-fpm:
  service.running:
    - enable: True
    - require:
      - pkg: php7
