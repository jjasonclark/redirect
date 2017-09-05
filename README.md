# Redirector #

TL;DR Rack app to redirect traffic. Rails admin app for CRUD actions on redirects.

## Overview ##

This application performs HTTP redirects. It includes additional services to create and modify redirects.

* **Redirector**: Rack based application to redirect traffic based on request URL
* **Admin**: Rails based application to perform CRUD on redirect records
* **Postgresql**: DB used by Rails application to store redirect records
* **Prometheus**: Metrics collection server
* **Postgresql-exporter**: Prometheus data exporter for Postgresql DB
* **Grafana**: Graphical dashboard to display Prometheus metrics

Use the admin site to add and remove regex based searches of URLs and their redirect targets. Use Grafana to create custom metics dashboard to display status. Use the redirector to redirect URLs fetched from the admin site.

## URLS ##

* Redirector at http://localhost:8080
* Admin panel at http://localhost:3000
* Metrics dashboard at http://localhost:4000
* Raw metrics at http://localhost:9090

## Background ##

The goal of this project is to create a spike application to try out the idea of a HTTP redirecting services that gets its URLs to rediect from another service. Scaling these services will eventually happen, so initially they are created as two different services instead of a single monolith. The CRUD based admin application made from Rails. And a Rake based application just for redirects. And as a spike project getting metrics from it's use will help determin how and what changes will be needed for a production version.

## Developer Setup ##

Setup is a two part process. The first is to setup the servers for admin, redirecting, and monitoring. This is automated via Docker Compose. Then the second part, a manual process, is modifying your local environment to allow using internet domain names to point to the development servers.

__Setup servers__

1. `bin/setup`
1. `docker-compose up -d`

__Setup domain names__

For local testing you will need to configure some internet domain names to point to your local server. Modify your `/etc/hosts` (Mac/Linux) or `c:\Windows\System32\Drivers\etc\hosts` (Windows) file as a super user (root). Add entries for each domain using the following format: `127.0.0.1`, then a tab or space, then domain name.

Example hosts file:

    127.0.0.1   my.example.com
    127.0.0.1   other.domain.gov

Many tutorials exist online for more information
* http://www.makeuseof.com/tag/modify-manage-hosts-file-linux/
* https://www.howtogeek.com/howto/27350/beginner-geek-how-to-edit-your-hosts-file/

## TODOs ##

* Create Grafana dashboard of redirect counts
* Add log catcher to gather logs to same location
* Add dynamic scalling of redirector services
