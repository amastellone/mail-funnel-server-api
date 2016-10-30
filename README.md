# README
Mail-Funnel REST Server


### Install
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