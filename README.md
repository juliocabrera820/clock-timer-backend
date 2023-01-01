[![Author](https://img.shields.io/badge/author-juliocabrera820-3D3D4D?color=233D3D4&style=flat)](https://github.com/juliocabrera820)
[![Languages](https://img.shields.io/github/languages/count/juliocabrera820/clock-timer-backend?color=%233D3D4&style=flat)](#)
[![Stars](https://img.shields.io/github/stars/juliocabrera820/sinatra-demo?color=233D3D4&style=flat)](https://github.com/juliocabrera820/clock-timer-backend/stargazers)
[![Forks](https://img.shields.io/github/forks/juliocabrera820/sinatra-demo?color=233D3D4&style=flat)](https://github.com/juliocabrera820/clock-timer-backend/network/members)
[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails)

# Clock timer

Ruby version - 2.7.2

## Getting started

Install redis

Install postgresql

`bundle install`

## Database creation

`rake db:create`

`rake db:migrate`

## Tests

`rake db:migrate RAILS_ENV=test`

`bundle exec foreman run --env .env.test rspec spec/`

## Development

Then run `foreman start -f Procfile.dev` to run rails app and copy
the following url in browser `http://localhost:5000/graphiql`
