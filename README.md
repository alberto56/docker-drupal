A Drupal Docker image for testing and development
=====

This project was developed in order to allow local development of Drupal modules, particularly [Realistic Dummy Content](https://www.drupal.org/project/realistic_dummy_content).

The idea is to provide a starting point to easily provision a development environment using Docker on a CoreOS Vagrant machine. For a tutorial on how to use Docker and Vagrant, see the first class at [Dcycle U.](http://u.dcycle.com/).

The blog post [Continuous integration with Circle CI and Docker for your Drupal project (Dcycle project, Feb. 20, 2015)](http://dcycleproject.org/blog/92) provides more details on how to set this up.

Branches
-----

The following branches' code always download **the latest stable** version of Drupal. For example, running 7.x-dev-1.x might download 7.23 one day, and 7.24 the next. Branch names use the Drupal branch followed by the type of box (dev for development--the only one for now--, eventually prod and test), followed by the version branch of the Dockerfile:

 * [6.x-dev-1.x](https://github.com/alberto56/docker-drupal/tree/6.x-dev-1.x) [![Circle CI](https://circleci.com/gh/alberto56/docker-drupal/tree/6.x-dev-1.x.svg?style=svg)](https://circleci.com/gh/alberto56/docker-drupal/tree/6.x-dev-1.x)
 * [7.x-dev-1.x](https://github.com/alberto56/docker-drupal/tree/7.x-dev-1.x) [![Circle CI](https://circleci.com/gh/alberto56/docker-drupal/tree/7.x-dev-1.x.svg?style=svg)](https://circleci.com/gh/alberto56/docker-drupal/tree/7.x-dev-1.x)
 * [7.x-dev-2.x](https://github.com/alberto56/docker-drupal/tree/7.x-dev-2.x) (recommended) [![Circle CI](https://circleci.com/gh/alberto56/docker-drupal/tree/7.x-dev-2.x.svg?style=svg)](https://circleci.com/gh/alberto56/docker-drupal/tree/7.x-dev-2.x)
 * [8.0.x-dev-1.x](https://github.com/alberto56/docker-drupal/tree/8.0.x-dev-1.x) [![Circle CI](https://circleci.com/gh/alberto56/docker-drupal/tree/8.0.x-dev-1.x.svg?style=svg)](https://circleci.com/gh/alberto56/docker-drupal/tree/8.0.x-dev-1.x)

In this branch, the Drupal version is hard-coded, so that the same version of the Dockerfile always downloads **a fixed version of Drupal**. This is considered by some to be more robust, less prone to breaking:

 * [8.0.x-dev-1.x-fixed](https://github.com/alberto56/docker-drupal/tree/8.0.x-dev-1.x-fixed) [![Circle CI](https://circleci.com/gh/alberto56/docker-drupal/tree/8.0.x-dev-1.x-fixed.svg?style=svg)](https://circleci.com/gh/alberto56/docker-drupal/tree/8.0.x-dev-1.x-fixed)

Tags
-----

Tags are named by replacing the `x` in the Dockerfile version with a minor version number, and for fixed Drupal versions, by appending the Drupal version, for example:

 * `8.0.x-dev-1.0` to use the latest stable version of Drupal 8.0.x, whatever it is.
 * `8.0.x-dev-1.0-8.0.0-beta10` to use `8.0.0-beta10`.

The tags are not guaranteed to keep up with the Drupal versions.

Example usage
-----

See the Dockerfiles and scripts in [Realistic Dummy Content](http://drupal.org/project/realistic_dummy_content).
