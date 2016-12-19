# Mail-Funnel-Server API
[![Coverage Status](https://circleci.com/gh/vaskaloidis/mail-funnel-server-api.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/vaskaloidis/mail-funnel-server-api.svg?style=shield&circle-token=:circle-token) [![Coverage Status](https://coveralls.io/repos/github/vaskaloidis/mail-funnel-server-api/badge.svg?branch=master)](https://coveralls.io/github/vaskaloidis/mail-funnel-server-api?branch=master)


Rails JSON API RESTful Server, that also handles Shopify Webhooks and a Rails Cron-Job Worker.

## Server-Features
The purpose of this server is to serve the mail-funnel-client (soon available in app-store) with the following services: Shopify Webhooks, REST CRUD JSON Web-Services and a Ruby background-job worker.

### Shopify Webhooks
- Shopify Webhooks - Shopify-API is configured and authenticated and the hooks are ready in /app/api/api.rb

### REST JSON Web-Services
- REST Web-Service JSON API that serves CRUD operations for 
- Security: https://www.codeschool.com/blog/2014/02/03/token-based-authentication-rails/

### Sends emails using SendGrid
**Possible Rails Libraries:**  
- https://github.com/stephenb/sendgrid  
- https://github.com/PavelTyk/sendgrid-rails  
- https://devcenter.heroku.com/articles/sendgrid  
- Config ActionMailer to use Sendgrid - https://sendgrid.com/docs/Integrate/Frameworks/rubyonrails.html  
- Sendgrid Ruby Lib - https://sendgrid.com/docs/Integrate/Code_Examples/v2_Mail/ruby.html

### Background-Jobs Worker
- A background process (IE: Job / Worker)
- We use **Heroku Scheduler:** https://devcenter.heroku.com/articles/scheduler
- Heroku Jobs: https://devcenter.heroku.com/articles/scheduled-jobs-custom-clock-processes
- **Heroku Alternative Worker:** https://devcenter.heroku.com/articles/delayed-job
- One last alternative that is compatible - https://github.com/Rykian/clockwork
- Worker runs every 5 minutes , iterating through each row in the Jobs table
- The Worker checks each Job's and evaluates if it should be executed based on this algorithm:

```
1. Evaluate the Job's "frequency" value and "frequency-value" value. 
   1.1 `Frequency:String` = execute_once (default), (currently disabled: execute_twice, execute_thrice)
   1.2 `Frequency-Value::Integer` (military-style / minutes are multiples of 5) = 0030, 1100, 1345, 2005
2 Check the `Executed:Boolean` param, check if job has been executed yet 
   2.1 (Disabled)'Executed_Count:Integer` param (record how many times it has been executed) 
```


### Workers
- **Job Host** - Worker: Iterates through client Jobs, and sends emails to everybody on list
- **Crono**: Time based worker - https://github.com/plashchynski/crono

### Mailers / Sendgrid Mailers
- **Sendgrid-ActionMailer** - https://github.com/eddiezane/sendgrid-actionmailer

## Development
- CI Server - https://github.com/travis-ci
- First download and install Ngrok (http://ngrok.com but we have a
in our apps/bin), and run it

### Developer Setup

```
./ngrok http 3001   # This starts ngrok
```
You will need to configure your .env first. The .env can be used with the `gem 'dotenv'`

```env
RAILS_ENV=Development
APP_NAME=mailfunnel-server
APP_KEY=##KEY########
APP_SECRET=##SECRET###
APP_URL=http://GENERATED-URL.ngrok.io/api/ # Or your servers URL
APP_SCOPE = "read_orders, read_products"
```

Then run the server on port 3001

```bash
rails s -p 3001
```


## Mail-Funnel REST Server


**Endpoints**

```
Rails JSON REST API
http://mailfunnel.bluehelmet.io

Shopify API Endpoint
http://mailfunnel.bluehelmet.io/api/
```

**API JSON Authentication** (Task)
	
- https://github.com/doorkeeper-gem/doorkeeper
- http://tutorials.pluralsight.com/ruby-ruby-on-rails/token-based-authentication-with-ruby-on-rails-5-api
- https://github.com/nsarno/knock


**API Docs:** 

- (Task) Setup Gelato - https://gelato.io/

## Production Server

**Heroku**

- Ruby on Rails application hosting.
- https://dashboard.heroku.com/

**Travis-CI** OR **Circle-CI**

**Reviewable.io**

- Merge Review Tool
- https://reviewable.io/reviews#-
**Review-Ninja Admin:** 

- https://app.review.ninja/

**Sentry.io**

- https://sentry.io/blue-helmet/mail-funnel-client/getting-started/ruby-rails/

**Dependency Security Analyzer** 

- https://www.deppbot.com/repos
- Github Webhook trigers an audit after every push
