# Directory Structure and Files
- ``.keep`` **allows git to keep the empty file.**
- Any files starting with `_` underscore => partials.

```bash
├── app
│   ├── assets
│   ├── channels
│   ├── controllers
│   ├── helpers
│   ├── javascript
│   ├── jobs
│   ├── mailers
│   ├── models
│   └── views
├── bin
├── config
│   ├── environments
│   ├── initializers
│   ├── locales
│   └── webpack
├── db
├── Docs
├── lib
│   ├── assets
│   └── tasks
├── log
├── node_modules
├── public
├── storage
├── test
│   ├── channels
│   ├── controllers
│   ├── fixtures
│   ├── helpers
│   ├── integration
│   ├── mailers
│   ├── models
│   └── system
├── tmp
│   ├── cache
│   ├── miniprofiler
│   ├── pids
│   ├── sockets
│   └── storage
└── vendor
```

**app**

```
├── app
│   ├── assets (images, js, css)
│   ├── channels
│   ├── controllers (dbs interaction, views looks up for what to display)
│   ├── helpers (view helpers, custom methods)
│   ├── javascript
│   ├── jobs
│   ├── mailers (emailing)
│   ├── models (db models, algorithms)
│   └── views (views, htmls codes)
```

**config**
- Configurations, runs when application starts
```
config
├── application.rb (main configuration files, dependencies (csvs, images, ....) loading, timezone, default locales)
├── boot.rb
├── cable.yml
├── credentials.yml.enc
├── database.yml (database configurations)
├── environment.rb
├── environments
│   ├── development.rb
│   ├── production.rb
│   └── test.rb
├── initializers (mail connections apis, e.t.c....)
│   ├── application_controller_renderer.rb
│   ├── assets.rb (rails assets pipelines)
│   ├── backtrace_silencers.rb
│   ├── content_security_policy.rb
│   ├── cookies_serializer.rb
│   ├── filter_parameter_logging.rb
│   ├── inflections.rb
│   ├── mime_types.rb
│   ├── permissions_policy.rb
│   └── wrap_parameters.rb
├── locales (different language supports customization)
│   └── en.yml
├── master.key
├── puma.rb
├── routes.rb (routes )
├── spring.rb
├── storage.yml
├── webpack
│   ├── development.js
│   ├── environment.js
│   ├── production.js
│   └── test.js
└── webpacker.yml
```

**db**
- Databases
```
db
├── development.sqlite3 (default development db)
├── production.sqlite3 (default prod db)
├── schema.rb (Auto generated from state of db, cols data types on dbs, ....)
├── seeds.rb (populating dbs while runing db:seed)
└── test.sqlite3 (default test db)
```

**lib**
```
lib
├── assets
└── tasks (custom rake tasks command line, tasks scheduling)
```

**public**

```
public/
├── 404.html (customizable)
├── 422.html (customizable)
├── 500.html (customizable)
├── favicon.ico
└── robots.txt (SEO)
└── ...
```

**tests**
- Unit testing of different application modules
```
test/
├── application_system_test_case.rb
├── channels
│   └── application_cable
├── controllers
├── fixtures
│   └── files
├── helpers
├── integration
├── mailers
├── models
├── system
└── test_helper.rb
```

**vendor**
- Stores Frontend integrations, client sides (React, Angular, ....)
- For backward compatibality

**Gemfile**
- Packages, dependencies, libraries on a project
- Ruby modules
- Gem files / dependencies

**Gemfile.lock**
- Never edited
- sub dependencies nesteds (sub libraries for nested gems)