A Drupal Docker image for testing and development
=====

Which branch to use?
-----

Branch naming comprises three parts: the Drupal version (6.x, 7.x, ...); the proposed usage (dev = module development, the only one for now); and the version of this Dockerfile (1.x, 2.x, ...).

Each branch should contain information in its README file:

 * [7.x-dev-1.x](https://github.com/alberto56/docker-drupal/tree/7.x-dev-1.x)
 * _This branch_: [7.x-dev-2.x](https://github.com/alberto56/docker-drupal/tree/7.x-dev-2.x)
 * [6.x-dev-1.x](https://github.com/alberto56/docker-drupal/tree/6.x-dev-1.x) is experimental.

This branch: 7.x-dev-2.x
-----

This is the recommended branch for Drupal 7 module development. It is a fork of [ricardoamaro's docker-drupal project](https://github.com/ricardoamaro/docker-drupal), with a few modifications for testing.

Version history
-----

7.x-dev-2.0: branched off b7alt, added some error displaying, a library for enabling simpletest, and coder review.

Example usage
-----

See the Dockerfiles and scripts in [Realistic Dummy Content](http://drupal.org/project/realistic_dummy_content).
