# debug database setup

$ psql health_agreements_dev

# start DB

postgres -D /usr/local/var/postgres/

or

pg_ctl -D /usr/local/var/postgres start

# manual DB backup

heroku pg:backups capture --app evening-badlands-7297

# manual DB backup download

heroku pg:backups public-url b001 --app evening-badlands-7297
# where b001 is backup ID

or one liner

$ curl -o latest.dump `heroku pg:backups public-url`

# schedule DB backup

$ heroku pg:backups schedule DATABASE_URL --at '02:00 America/Los_Angeles' --app evening-badlands-7297

# view DB backup schedule

$ heroku pg:backups schedules --app evening-badlands-7297

# locally use backup to restore

# see https://devcenter.heroku.com/articles/heroku-postgres-import-export

# use backup file to manually restore on prod

$heroku pg:backups restore b101 DATABASE_URL --app sushi

# locally restore from dump file

rake db:drop
rake db:create
pg_restore -O -d health_agreements_dev latest.dump

# also look into this tool for prod pull / tests:
http://www.rubydoc.info/gems/taps/0.3.24/frames

# transfer prod DB to stage:

 heroku pg:backups restore flailing-papaya-42::b101 DATABASE_URL

e.g:

 heroku pg:backups restore evening-badlands-7297::b022 DATABASE_URL --app symbolofhealth-staging

or

 heroku pg:backups restore 'https://s3.amazonaws.com/me/items/mydb.dump' DATABASE -a sushi


# maybe this is what I want in lieu of rake db:setup (to run schema.rb)

rake db:schema:load

(via : http://stackoverflow.com/questions/4116067/purge-or-recreate-a-ruby-on-rails-database)


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



# generate SECRET_KEY_BASE env var for heroku

rake secret

(then enter on heroku config)