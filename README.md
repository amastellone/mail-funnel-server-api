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
JSON REST Endpoint for Rails Scaffolded Objects
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
CI Server - https://github.com/travis-ci
First download and install Ngrok (http://ngrok.com but we have a
in our apps/bin), and run it
```

```
You will need to configure your .env first
```
# .env
RAILS_ENV=Development
APP_NAME=mailfunnel-server
APP_KEY=##KEY########
APP_SECRET=##SECRET###
APP_URL=http://GENERATED-URL.ngrok.io/api/ # Or your servers URL
APP_SCOPE = "read_orders, read_products"
```

```
rails s -p 3001
# This creates your server on http://localhost:3001
```



### Scaffold Commands Ran
These are outdated, and models are vastly different
```bash
 1249  rails g migration add_uuid_to_books
 1250  rails g migration enable_uuid_extension
 1251  bundle
 1252  rails g campaign hook_uuid:references campaign_job_id:references
 1253  rails g scaffold campaign hook_uuid:references campaign_job_id:references
 1254  rails g scaffold campaign_job campaign_id:references job_uuid:references position:integer
 1255  rails g scaffold user name:string email:string app_uuid:references
 1256  rails g scaffold HooksConstant name:string uuid:references
 1257  cd ../mail-funnel-server
 1258  rails g scaffold Email email:string name:string email_list_uuid:references
 1259  rails d scaffold Email
 1260  rails g scaffold Email email:string name:string email_list_uuid:references app_uuid:references
 1261  rails g scaffold job time:references subject:string content:text email_list_uuid:references app_uuid:references hook_uuid:references user_local_id:integer
 1262  rails g app user_local_id:integer name:string api_key:string api_secret:text
 1263  rails g scaffold app user_local_id:integer name:string api_key:string api_secret:text
 1264  rails g scaffold email_lists
 1265  rails d scaffold email_lists
 1266  rails g scaffold email_lists app_uuid:references user_local_id:integer name:string description:text
 1267  rails g scaffold hooks name:text identifier:text
```
