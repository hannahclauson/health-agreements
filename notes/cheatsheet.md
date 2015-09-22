# debug database setup

$ psql health_agreements_dev

# start DB

postgres -D /usr/local/var/postgres/

# describe a table:

health_agreements_dev=# \d+ Companies

# New model

- rails generate model lowercasepluralname
- config/routes -- add resource
- rails generate contoller Capitalpluralname
- setup appropriate methods:
  - new (get)  
  - create (post)
  - edit
  - update
  - index
  - show
  - destroy


To reset DB on heroku:

$ heroku pg:reset DATABASE

 !    WARNING: Destructive Action
 !    This command will affect the app: evening-badlands-7297
 !    To proceed, type "evening-badlands-7297" or re-run this command with --confirm evening-badlands-7297

> evening-badlands-7297
Resetting DATABASE_URL... done