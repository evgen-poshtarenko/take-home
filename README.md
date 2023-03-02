# Development environment setup with Docker

## Installation
* make sure you have installed `docker` and `docker-compose`
* it is better to add your *nix user to the `docker` group ([sudo] s not needed than)

### Copy the following:
  * `cp .env/development/database.example .env/development/database`
  * `cp .env/development/web.example .env/development/web`

### Create database and run migrations:
  * `docker-compose run web bundle exec rails db:create db:migrate`

### Running application:
  * `docker-compose up`

### Running tests:
  * `docker-compose run web bundle exec rspec`

