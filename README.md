# Mail-Funnel-Server API
Rails JSON API RESTful Server, that also handles Shopify Webhooks and a Rails Cron-Job Worker.

## Server-Features
The purpose of this server is to serve the mail-funnel-client (soon available in app-store) with the following services: Shopify Webhooks, REST CRUD JSON Web-Services and a Ruby background-job worker.

### Shopify Webhooks
- Shopify Webhooks - Shopify-API is configured and authenticated and the hooks are ready in /app/api/api.rb

### REST JSON Web-Services
- REST Web-Service JSON API that serves CRUD operations for 

### Background-Jobs Worker
- A background process (IE: Job / Worker)
- Worker runs every 5 minutes , iterating through each row in the Jobs table
- The Worker checks each Job's and evaluates if it should be executed based on this algorithm:
```
* Evaluate the Job's "frequency" value and "frequency-value" value. 
** `Frequency:String` = execute_once (default), (currently disabled: execute_twice, execute_thrice)
** `Frequency-Value::Integer` (military-style / minutes are multiples of 5) = 0030, 1100, 1345, 2005
* Check the `Executed:Boolean` param, check if job has been executed yet 
** (Disabled)'Executed_Count:Integer` param (record how many times it has been executed) 

- Job Host - Worker: Iterates through client Jobs, and sends emails to everybody on list
```

Mail-Funnel REST Server.

There are two endpoints:

```
Rails JSON REST API
http://mailfunnel.bluehelmet.io

Shopify API Endpoint
http://mailfunnel.bluehelmet.io/api/
```
## Testing 

Shoulda - https://github.com/thoughtbot/shoulda

RSpec API - https://github.com/rspec-api/rspec-api

MiniTest 
- http://docs.seattlerb.org/minitest/
- https://github.com/seattlerb/minitest

Minitest in RubyMine 
- https://www.jetbrains.com/ruby/whatsnew/?fromIDE=#v2016-3-minitestspec

Generate Rspec based on Features
https://www.airpair.com/rspec/posts/gert

**TODO** Read more IDE Features - https://blog.jetbrains.com/ruby/2016/11/better-puppet-support/

## Development / Usage
- CI Server - https://github.com/travis-ci
- First download and install Ngrok (http://ngrok.com but we have a
in our apps/bin), and run it

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

## Production Server

**Heroku**
Ruby on Rails application hosting.
https://dashboard.heroku.com/

**Travis-CI**


**Reviewable.io**
Merge Review Tool
https://reviewable.io/reviews#-
**Review-Ninja Admin:** https://app.review.ninja/

**Sentry.io**
https://sentry.io/blue-helmet/mail-funnel-client/getting-started/ruby-rails/

**Dependency Security Scanner** - https://www.deppbot.com/repos
