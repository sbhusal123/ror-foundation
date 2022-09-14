# Heroku Deployment
- Push repo to github.
- Install heroku cli.
- Create a heroku app: `heroku create <app_name>`
- Set heroku stack version to 18: `heroku stack:set heroku-18 --app <app_name>`
- Configure gem file to use postgres: **remove sqlite and add pg gem.**
- Push app to heroku: ``git push heroku main``
- Configure env variables: ``heroku config:set VAR=Value``
- Migrate DB: ``heroku run rake db:migrate``

# Commands:
- Rails console: ``heroku run rails c``

[S3 Bucket And Credentials Setup](https://www.youtube.com/watch?v=nzLMA9WZqMM)