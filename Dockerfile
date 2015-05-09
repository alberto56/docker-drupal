##
# Drupal/SSH with Nginx, PHP5 and SQLite
##
FROM ubuntu
MAINTAINER alberto56, forked from http://www.github.com/b7alt/ by b7alt

#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y supervisor openssh-server nginx php5-fpm php5-sqlite php5-gd php-apc git emacs
RUN apt-get -y install curl
RUN apt-get -y install php5-curl
RUN update-rc.d nginx disable
RUN update-rc.d php5-fpm disable
RUN update-rc.d supervisor disable
RUN update-rc.d ssh disable
RUN apt-get -y install php5 libapache2-mod-php5 php5-mcrypt
RUN php -v
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer global require drush/drush:dev-master
RUN ln -s /root/.composer/vendor/drush/drush/drush /bin/drush
RUN drush version
# not working...RUN sed -i "s/^display_errors.*$/display_errors = On/" /etc/php5/cli/php.ini

EXPOSE 80

RUN mkdir -p /var/run/sshd /srv/drupal/www /srv/drupal/config /srv/data /srv/logs /tmp

ADD docker-resources/site.conf /srv/drupal/config/site.conf
ADD docker-resources/nginx.conf /nginx.conf
ADD docker-resources/php-fpm.conf /php-fpm.conf
ADD docker-resources/supervisord.conf /supervisord.conf
ADD docker-resources/settings.php.append /settings.php.append

RUN cd /tmp && drush dl drupal-8.0.x && mv /tmp/drupal*/* /srv/drupal/www/ && rm -rf /tmp/*
RUN cd /srv/drupal/www && cp ./sites/default/default.services.yml ./sites/default/services.yml
RUN sed -i "s/<?php/<?php\nerror_reporting(E_ALL);\nini_set('display_errors', TRUE);\nini_set('display_startup_errors', TRUE);/g" /srv/drupal/www/index.php
RUN chmod a+w /srv/drupal/www/sites/default && mkdir /srv/drupal/www/sites/default/files
RUN chown -R www-data:www-data /srv/drupal/www/
RUN cp /srv/drupal/www/sites/default/default.settings.php /srv/drupal/www/sites/default/settings.php
RUN chmod a+w /srv/drupal/www/sites/default/settings.php
RUN chown www-data:www-data /srv/data

RUN chmod a+w /srv/drupal/www/sites/default/files
RUN mkdir /srv/drupal/www/db
RUN cd /srv/drupal/www/ && drush -y site-install standard --account-name=admin --account-pass=test --db-url=sqlite://db/.ht.sqlite

RUN cat /settings.php.append >> /srv/drupal/www/sites/default/settings.php

RUN cd /srv/drupal/www/ && drush -y dl environment_indicator coder devel
RUN chown -R www-data:www-data /srv/drupal/www/db
RUN chmod -R 777 /srv/drupal/www/db
RUN cd /srv/drupal/www/ && drush -y en environment_indicator coder_review simpletest devel views_ui

#RUN ls -al /srv/drupal/www/sites/default/files
#RUN chmod a-w /srv/drupal/www/sites/default/settings.php

#RUN chown -R www-data:www-data /srv/drupal/www/

#RUN echo "root:root" | chpasswd
#RUN sed --in-place=.bak 's/without-password/yes/' /etc/ssh/sshd_config

ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/supervisord.conf", "-e", "trace" ]
