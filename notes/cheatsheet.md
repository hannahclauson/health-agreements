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

# to repair the v0.0 / v1.0 schema conflict, I did

db:drop
db:create
(then restore from local bck / pgback)
db:migrate

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


# Doing a pg:restore to make staging mirror production ... but then rake is out of sync
# See: http://stackoverflow.com/questions/33998209/how-can-i-fix-my-migrations-activerecordmigrator-current-version-and-dbmigra

In this case, I'm dumping prod -> stage, and want to test the new guideline tagging on staging

But, when I do the pg:restore from prod, then do the migration, it errs w 'already existing relation'. It looks like its trying to rerun the "20151112165020" migration (legal documents) even though that already exists in the DB. So, I'll add that migration timestamp to the DB:

First check the migration DB status:

    heroku run ./bin/rails dbconsole --remote staging

(This will ask for password. Its after the ":" in the DATABASE_URL env var on heroku)

Then:

    \d+ schema_migrations

And:

    SELECT * FROM schema_migrations;

And I see:

=> SELECT * FROM schema_migrations;
    version     
----------------
 20150902223734
 20151112155654
(2 rows)

So then I:

    insert into schema_migrations(version) values ('20151112165020');

And rerunning the select, I see it added.

And re-running db:migrate on staging ... the final migration (20151114003406) is added and working! Great

# Push build to production

Check circleCI: https://circleci.com/gh/sjezewski/health-agreements

(oh ... I turned off pushing to prod once new tag appears 
... I could make that into detecting a tag + on a branch?)

Once build succeeds:

$ git fetch --tags

To see tags. Should see release-1.0.buildnum


# generate SECRET_KEY_BASE env var for heroku

rake secret

(then enter on heroku config)