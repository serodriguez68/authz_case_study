# Authz case study – Using Authz to authorize a two-sided marketplace

## About Authz
Authz is an opinionated almost-turnkey solution for managing authorization in your Rails application.

Read everything about this project on the [official github repo](https://github.com/serodriguez68/authz).


## About this case study
This repo contains an application that demonstrates how to use [Authz](https://github.com/serodriguez68/authz) 
to fully authorize a typical ride sharing platform app that has a non-trivial role specification sheet.

[Read the details of the case study here](https://authzcasestudy.herokuapp.com/visitors/about).

We chose this case study because:

* Two-sided marketplaces are a very common use case for web applications.
We hope this case study becomes valuable and relatable documentation for the gem.

* Most developers are familiar with Uber-like apps, reducing the overhead required to understand the case study 
and allowing them to focus on the library’s features.

* The scenario is rich enough to allow the demonstrations of most of the library's features.

[You can interact with a live demo here](https://authzcasestudy.herokuapp.com/). Note that it resets once a day.

## Use this repo to try Authz yourself!
Clone this repo, go the the [README](https://github.com/serodriguez68/authz) of the gem and follow along. 

This repo has two branches:
-	`start` contains the full implementation of the ride sharing app **without** any type of authorization.  This is where you start.
-	`master` contains the fully authorized application. This is where you want to get to.

For your convenience, both branches contain the relevant seeds to get help you started.  
-	run `rails db:setup` if you are creating the db for the first time.
-	run `rails db:reset` if you want to completely reset the DB and reload it with the seeds.

### Requirements
- This is a standard Ruby on Rails application so you will need to have ruby installed.
- Authz is agnostic to the database engine you use.  However, this sample app uses a Postgres database, so 
make sure you install it on your computer. 