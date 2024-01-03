# RDS Calculator

Random Distribution System (RDS) Calculator, aka Loot Tables the web app.

Inspired by [Mike (Prof. Chuck)'s article](https://www.codeproject.com/Articles/420046/Loot-Tables-Random-Maps-and-Monsters-Part-I), this is an implementation in Ruby on Rails.

## Getting started

This is a standard Rails app that uses Postgres and Tailwind.
This app expects a modern Ruby version, likely 3.2.2+, and is built on Rails 7.

After bundling and running `rake db:create` and `rake db:migrate`, run the app with `./bin/dev`, as this will start the app with a paired watch process to recompile Tailwind.

## Data Model

The root model is the LootTable made up of a name.
A LootItem has a name, a parent LootTable, a probability, a min and max to make up a quantity range, a couple of options, and an optional link back to a LootTable other than its parent.
A Roll has a quantity and parent LootTable.
Loot has a name, a quantity, and a parent Roll.

Users of this system would create a LootTable, add LootItems to the table, "roll" (and therefore create Rolls) on the table, and get a consolidated list of LootItems (aka the Loot).
Think monster drops in role playing games or any of the game mastering tables from table top games.

## Testing

Run the tests with `rake test`.

## Deployment

Deployment is automatic with Railway using a Docker container on push to the `main` branch.