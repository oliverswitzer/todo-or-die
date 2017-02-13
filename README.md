
* Ruby version: ruby 2.1.5p273

* Database creation

- Install postgresql
- Create user: `todoordie`
```
$ psql -d postgres
postgres=# create role todoordie login createdb;
postgres-# \q
```

- Then create the database

```
rake db:create
```

* Database initialization

```
rake db:migrate
```

* How to run the test suite

```
rake db:test:prepare
```

For running Jasmine tests, start up the local development server and go to `localhost:3000/specs`
