# OD To Dos

Basic weekly task management application for the O'Donnell house. Built to be deployed on a Raspberry Pi that is port forwarding to allow access exclusively on Jake's home network.

Quick discalimer: since this app has almost no need for a "new user" flow, it simply seeds in the few people who will use it.

## Installation (MAYBE JUST MAKE THIS INSTALLATION ON `RaspberryPi` INSTRUCTIONS)

### Set Environment Variables

If you are implementing this for the O'Donnell household, `db/seeds/od_admins.rb` expects `dotenv` to load environment variables `JAKE_SEED_PWD` and `AUDREY_SEED_PWD`. Create a `.env` file at the project root and define those variables.

If you have forked this repo to roll your own version, you'll want to delete or replace all `db/seeds/od_*.rb` files. You'll also probably still want to create a `.env` file at the project root to define whatever environment variables you need.
