A simple Drupal Docker image for testing
=====

Please see [Drupal and Docker: creating a new Docker image based on an existing image, on Dcycle Project (9 Feb. 2015)](http://dcycleproject.org/blog/89).

This image is based on `d7alt/drupal` (which you can find by typing `docker search drupal`, or [on GitHub](https://github.com/b7alt/drupal)), but with the PHP-cUrl library added to it. The PHP-cUrl library is required to run the Drupal Simpletest module for automated testing.
