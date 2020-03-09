# Daily Tweet

 Daily Tweet is a real-time web application with basic tweet functionality.

## Tech Stack

Backend: Elixir/Phoenix expose GraphQL endpoint

Frontend: React/Apollo to query GraphQL API endpoint


## Setup

### Backend

1. Install Elixir ([official docs](https://elixir-lang.org/install.html))

2. Install dependencies: `mix deps.get`

3. Run server: `mix phx.server`

In detail, please take a look at `api/README.md`

### Frontend

1. Install Nodejs/yarn

2. Install dependencies: `yarn install`

3. Run app: `yarn start`

In detail, please take a look at `web/README.md`

## Deployment

A live demo is [https://daily-tweet.firebaseapp.com/](https://daily-tweet.firebaseapp.com/)

### Backend

For the demo, the server is running on [Heroku](https://heroku.com)

1. Sign up and install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)

2. `cd api & git init`

3. `heroku create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git"`

4. `heroku config:set POOL_SIZE=20`

5. `mix phx.gen.secret` and `heroku config:set SECRET_KEY_BASE="<SECRET PHOENIX JUST GENERATED ABOVE>"`

6. `git add .`

   `git commit -m "deploy in heroku"`
   
   `git push heroku master`


### Frontend

For the demo, the hosting is running on Firebase [Heroku](https://heroku.com)

1. Sign up and install firebase cli `npm install -g firebase-tools`

2. `firebase login` and `firebase init`

3.  Change api endpoint at .env

4. `yarn build`

3. `firebase deploy`
