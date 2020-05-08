source 'https://rubygems.org'

ruby '2.6.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails'
gem 'pg'
gem 'uglifier'
gem 'coffee-rails'
gem 'therubyracer', platforms: :ruby
gem 'haml-rails'
gem 'jquery-rails'
gem 'jbuilder'
gem 'will_paginate'
gem 'sass-rails'
gem 'devise'
gem 'bootstrap-sass'
gem "sentry-raven"
gem 'twitter'
gem 'liblinear-ruby'
gem 'whenever', :require => false
gem 'open_uri_redirections'
gem 'rails_12factor'
gem 'puma'
gem 'rufus-scheduler'
gem 'sidekiq-cron'
gem 'recursive-open-struct'
gem 'time_difference'

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers'
  gem 'letter_opener'
end

group :development do
  gem 'web-console'
  gem 'spring'
  gem 'bullet'
  gem 'derailed_benchmarks'
  gem 'stackprof'
end
