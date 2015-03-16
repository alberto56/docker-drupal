##
# Drupal/SSH with Nginx, PHP5 and SQLite
##
FROM ubuntu
MAINTAINER alberto56, forked from http://www.github.com/b7alt/ by b7alt

#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y supervisor openssh-server nginx php5-fpm php5-sqlite php5-gd drush php-apc git emacs
# not working...RUN sed -i "s/^display_errors.*$/display_errors = On/" /etc/php5/cli/php.ini
RUN apt-get -y install php5-curl
RUN update-rc.d nginx disable
RUN update-rc.d php5-fpm disable
RUN update-rc.d supervisor disable
RUN update-rc.d ssh disable

EXPOSE 80

RUN mkdir -p /var/run/sshd /srv/drupal/www /srv/drupal/config /srv/data /srv/logs /tmp

ADD docker-resources/site.conf /srv/drupal/config/site.conf
ADD docker-resources/nginx.conf /nginx.conf
ADD docker-resources/php-fpm.conf /php-fpm.conf
ADD docker-resources/supervisord.conf /supervisord.conf
ADD docker-resources/settings.php.append /settings.php.append

RUN cd /tmp && drush dl drupal && mv /tmp/drupal*/* /srv/drupal/www/ && rm -rf /tmp/*
RUN sed -i "s/<?php/<?php\nerror_reporting(E_ALL);\nini_set('display_errors', TRUE);\nini_set('display_startup_errors', TRUE);/g" /srv/drupal/www/index.php
RUN chmod a+w /srv/drupal/www/sites/default && mkdir /srv/drupal/www/sites/default/files
RUN chown -R www-data:www-data /srv/drupal/www/
RUN cp /srv/drupal/www/sites/default/default.settings.php /srv/drupal/www/sites/default/settings.php
RUN chmod a+w /srv/drupal/www/sites/default/settings.php
RUN chown www-data:www-data /srv/data


#RUN chmod a+w /srv/drupal/www/sites/default/files
RUN cd /srv/drupal/www/ && drush -y site-install standard --account-name=admin --account-pass=test --db-url=sqlite:sites/default/files/.ht.sqlite

RUN cat /settings.php.append >> /srv/drupal/www/sites/default/settings.php

RUN cd /srv/drupal/www/ && drush -y dl environment_indicator coder-7.x-2.4 devel views responsive_bartik
RUN cd /srv/drupal/www/ && drush -y en environment_indicator coder_review simpletest devel views views_ui responsive_bartik
RUN cd /srv/drupal/www/ && drush -y vset theme_default responsive_bartik
RUN cd /srv/drupal/www/ && drush -y vset block_cache 1 --yes
RUN cd /srv/drupal/www/ && drush -y vset cache_lifetime 300 --yes
RUN cd /srv/drupal/www/ && drush -y vset page_cache_maximum_age 300 --yes

RUN cd /srv/drupal/www/ && drush -y vset preprocess_css 1 --yes
RUN cd /srv/drupal/www/ && drush -y vset preprocess_js  1 --yes


RUN ls -al /srv/drupal/www/sites/default/files
RUN chown -R www-data:www-data /srv/drupal/www/sites/default/files/.ht.sqlite
RUN chmod a-w /srv/drupal/www/sites/default/settings.php

RUN chown -R www-data:www-data /srv/drupal/www/

RUN echo "root:root" | chpasswd
RUN sed --in-place=.bak 's/without-password/yes/' /etc/ssh/sshd_config

ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/supervisord.conf", "-e", "trace" ]
