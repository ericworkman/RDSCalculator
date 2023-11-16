# RDS Calculator

Random Distribution System (RDS) Calculator, aka Loot Tables the web app.

Inspired by [Mike (Prof. Chuck)'s article](https://www.codeproject.com/Articles/420046/Loot-Tables-Random-Maps-and-Monsters-Part-I), this is an implementation in Ruby on Rails.

## Getting started

This is a standard Rails app that uses Postgres and Tailwind.
This app expects a modern Ruby version, likely 3.2.2+, and is built on Rails 7.

After bundling and running `rake db:create` and `rake db:migrate`, run the app with `./bin/dev`, as this will start the app with a paired watch process to recompile Tailwind.

## Testing

Run the tests with `rake test`.

## Deployment

Deployment currently is with Digital Ocean App Platform using a Docker container.
You'll need to be logged into the team and container registry with `doctl`.

```
docker build . -t registry.digitalocean.com/rdscalculatorregistry/app --platform=linux/amd64
docker push registry.digitalocean.com/rdscalculatorregistry/app
```
