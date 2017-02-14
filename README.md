
* Ruby version: ruby 2.3.1p112

## Database creation

*For first time setup* 
```
$ brew update
$ brew doctor
$ brew install postgres
```

Create user: `todoordie`

```
$ psql -d postgres
postgres=# create role todoordie login createdb;
postgres-# \q
```

Then create the database

```
bundle exec rake db:create
```

#### Running migrations

```
bundle exec rake db:migrate
```

#### To start and stop postgres

To start postgres:
```
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
```

To stop postgres 
```
pg_ctl -D /usr/local/var/postgres stop -s -m fast
```

## How to run the test suite

```
bundle exec rake db:test:prepare
```

For running Jasmine tests, start up the local development server and go to `localhost:3000/specs`
