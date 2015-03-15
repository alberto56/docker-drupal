A simple Drupal Docker image for testing
=====

Which branch to use?
-----

Branch naming comprises three parts: the Drupal version (6.x, 7.x, ...); the proposed usage (dev = module development, the only one for now); and the version of this Dockerfile (1.x, 2.x, ...).

Each branch should contain information in its README file:

 * _This branch_: [7.x-dev-1.x](https://github.com/alberto56/docker-drupal/tree/7.x-dev-1.x)
 * [7.x-dev-2.x](https://github.com/alberto56/docker-drupal/tree/7.x-dev-2.x)
 * [6.x-dev-1.x](https://github.com/alberto56/docker-drupal/tree/6.x-dev-1.x) is experimental.

This branch: 7.x-dev-1.x
-----

This branch is based on`d7alt/drupal` (which you can find by typing `docker search drupal`, or [on GitHub](https://github.com/b7alt/drupal)), but with the PHP-cUrl library added to it. The PHP-cUrl library is required to run the Drupal Simpletest module for automated testing. Additional information can be found on the blog post [Drupal and Docker: creating a new Docker image based on an existing image, on Dcycle Project (9 Feb. 2015)](http://dcycleproject.org/blog/89).
