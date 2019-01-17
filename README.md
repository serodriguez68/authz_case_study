# Authz case study – Using Authz to authorize a two-sided marketplace

## About Authz
Authz is an opinionated almost-turnkey solution for managing authorization in your Rails application.

Read everything about this project on the [official github repo](https://github.com/serodriguez68/authz).


## About this case study
This repo contains an application that demonstrates how to use [Authz](https://github.com/serodriguez68/authz) 
to fully authorize a typical ride sharing platform app with [non-trivial role specification sheet](#to-live-demo).

We chose this case study because:

* Two-sided marketplaces are a very common use case for web applications.
We hope this case study becomes valuable and relatable documentation for the gem.

* Most developers are familiar with Uber-like apps, reducing the overhead required to understand the case study 
and allowing them to focus on the library’s features.

* The scenario is rich enough to allow the demonstrations of most of the library features.

You can interact with a live demo here. Note that it resets once a day.

## Use this repo to try Authz yourself
Try Authz yourself! Clone this repo, go the the [README](https://github.com/serodriguez68/authz) of the gem and follow along. 

This repo two  has branches:
-	`start` contains the full implementation of the ride sharing app **without** any type of authorization.  This is where you start.
-	`master` contains the fully authorized application. This is where you want to get to.

For your convenience, both branches contain the relevant seeds to get help you started.  
-	`rails db:setup` if you are creating the db for the first time
-	`rails db:reset` if you want to completely reset the DB and reload it with the seeds.
