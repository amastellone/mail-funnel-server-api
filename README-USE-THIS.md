# Mail-Funnel-Server API
Rails JSON API RESTful Server, that also handles Shopify Webhooks and a Rails Cron-Job Worker.

## Server-Features
The purpose of this server is to serve the mail-funnel-client (soon available in app-store) with the following services: Shopify Webhooks, REST CRUD JSON Web-Services and a Ruby background-job worker.

### Shopify Webhooks
- Shopify Webhooks - Shopify-API is configured and authenticated and the hooks are ready in /app/api/api.rb

### REST JSON Web-Services
- REST Web-Service JSON API that serves CRUD operations for 
- Security: https://www.codeschool.com/blog/2014/02/03/token-based-authentication-rails/

### Background-Jobs Worker
- A background process (IE: Job / Worker)
- Worker runs every 5 minutes , iterating through each row in the Jobs table
- The Worker checks each Job's and evaluates if it should be executed based on the following algorithm.  

**Job-Algorithm**  
1. Evaluate the Job's "frequency" value and "frequency-value" value.  
  - `Frequency:String` = execute_once (default), (currently disabled: execute_twice, execute_thrice)  
  - `Frequency-Value::Integer` (military-style / minutes are multiples of 5) = 0030, 1100, 1345, 2005
2. Check the `Executed:Boolean` param, check if job has been executed yet  
  - (Disabled)'Executed_Count:Integer` param (record how many times it has been executed) 

# Development
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

# Developer Resources

## Rspec Testing

https://github.com/rspec/rspec-rails  
https://github.com/thoughtbot/factory_girl_rails

### Testing
- http://brandonhilkert.com/blog/7-reasons-why-im-sticking-with-minitest-and-fixtures-in-rails/
- https://github.com/brandonhilkert/sucker_punch#cleaning-test-data-transactions

### Rails JSON JWT  
- http://rohitrox.github.io/2015/06/23/rails-api-backed-with-jwt/
- https://auth0.com/learn/json-web-tokens/
- https://auth0.com/blog/ruby-authentication-secure-rack-apps-with-jwt/
- https://www.sitepoint.com/introduction-to-using-jwt-in-rails/
- https://rails-api-jwt.herokuapp.com/api/docs/
- https://tools.ietf.org/html/draft-hammer-http-token-auth-01 
- https://blog.jalada.co.uk/tips-when-writing-an-api-in-ruby-on-rails/	 

**API JSON Authentication OLD-DEPRACATED** 
	
- https://github.com/doorkeeper-gem/doorkeeper
- http://tutorials.pluralsight.com/ruby-ruby-on-rails/token-based-authentication-with-ruby-on-rails-5-api
- https://github.com/nsarno/knock


**API Docs:** 

- (Task) Setup Gelato - https://gelato.io/


### Workers
- **Job Host** - Worker: Iterates through client Jobs, and sends emails to everybody on list
- **Crono** Time based worker - https://github.com/plashchynski/crono  
- **Resque / Delayed** - https://github.com/christiannelson/resque

### Mailers / Sendgrid Mailers
- **Sendgrid-ActionMailer** - https://github.com/eddiezane/sendgrid-actionmailer

## Deployment / Servers / Services
- **Github**
 - Pushed to GitHub
 - Code-Analysis Service(s) Executed Automatically
- **Circle-CI**
 - **coveralls.io** - Test Coverage Executed
 - **depbot.io** - Dependency Analysis  
- **Heroku-Staging**  
 - Builds temporary Heroku server, destroys 5 days after last use  
 - Creates new Heroku server to test production data
- **Heroku-Production**
  - **Rollbar.io** - Error / Log Monitoring + Reporting Tool
- **Mail-Funnel-Client**
 - **Rack::JWT** - This gem provides JSON Web Token (JWT) based authentication.


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
