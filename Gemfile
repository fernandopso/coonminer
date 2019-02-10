source 'https://rubygems.org'

ruby '2.6.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
# https://github.com/indirect/haml-rails
gem 'haml-rails'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# Pagination library for Rails, Sinatra, Merb, DataMapper, and more
# https://github.com/mislav/will_paginate
gem 'will_paginate'
gem 'sass-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Flexible authentication solution for Rails with Warden
# https://github.com/plataformatec/devise
gem 'devise'

# bootstrap-sass is a Sass-powered version of Bootstrap
# https://github.com/twbs/bootstrap-sass
gem 'bootstrap-sass'

# https://sentry.io/uai-developer/rails/getting-started/ruby-rails/
gem "sentry-raven"

# A Ruby interface to the Twitter API
# https://github.com/sferik/twitter
gem 'twitter'

# Liblinear-Ruby is Ruby interface of LIBLINEAR using SWIG.
# https://github.com/kei500/liblinear-ruby
gem 'liblinear-ruby'

# Whenever is a Ruby gem that provides a clear syntax for writing and deploying cron jobs.
# https://github.com/javan/whenever/
gem 'whenever', :require => false

# New Relic
gem 'newrelic_rpm'

# Applies a patch to OpenURI to optionally allow redirections from HTTP to HTTPS
# https://github.com/open-uri-redirections/open_uri_redirections
gem 'open_uri_redirections'

# This gem enables heroku serving assets in production
# https://github.com/heroku/rails_12factor
gem 'rails_12factor'

# A ruby web server built for concurrency
# https://github.com/puma/puma
gem 'puma'

# https://github.com/ondrejbartas/sidekiq-cron
gem 'rufus-scheduler'
gem 'sidekiq-cron'
# gem 'sidekiq'

# https://github.com/ruby-amqp/bunny
# gem 'bunny', '>= 2.9.2'

# https://github.com/aetherknight/recursive-open-struct
gem 'recursive-open-struct'

# https://github.com/tmlee/time_difference
gem 'time_difference'

# --------------------------------------------------------------------------- #

group :development, :test do
  gem 'pry-rails'

  # rspec-rails is a testing framework for Rails
  # https://github.com/rspec/rspec-rails
  gem 'rspec-rails'

  # A library for setting up Ruby objects as test data
  # https://github.com/thoughtbot/factory_girl
  gem 'factory_bot_rails'

  # Collection of testing matchers extracted from Shoulda
  # https://github.com/thoughtbot/shoulda-matchers
  gem 'shoulda-matchers'

  # Matchers to test before, after and around hooks
  # https://github.com/beatrichartz/shoulda-callback-matchers
  gem 'shoulda-callback-matchers'

  # Preview mail in the browser instead of sending.
  # https://github.com/ryanb/letter_opener
  gem "letter_opener"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Detect N+1 query problems (show in the log)
  # https://github.com/flyerhzm/bullet
  gem "bullet"
end
