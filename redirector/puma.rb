threads 1, 1
port ENV.fetch("PORT") { 80 }
environment ENV.fetch("RACK_ENV") { "development" }
daemonize false
