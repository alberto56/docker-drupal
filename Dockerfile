FROM b7alt/drupal

RUN apt-get update
RUN apt-get -y install php5-curl
