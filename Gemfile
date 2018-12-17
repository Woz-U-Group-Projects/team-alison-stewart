source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6', '>= 5.1.6.1'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'

# Use PostgreSQL for the database
gem 'pg',

# Use Puma as the app server
gem 'puma', '~> 3.7'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use the jquery ui widgets
gem 'jquery-ui-rails', '5.0.5'

# Use PostgreSQL for the database
gem 'pg', '0.18.4'

# Used for full text search
gem 'pg_search', '1.0.5'

# Used for SCSS general library
gem 'bourbon', '4.2.2'
# Used on top of bourbon for basic styling
gem 'neat', '1.7.2'
# Used for fonts and icons
gem 'font-awesome-sass', '4.3.0'

# Used for SEO meta tags
gem 'meta-tags', '2.0.0'

# Used for the admin console
gem 'activeadmin', '1.0.0.pre2'

# Used for interactive form selects
gem 'select2-rails', '4.0.1'

# Used for running long lasting jobs
gem 'delayed_job_active_record', '4.1.0'

# Used for authorization
gem 'cancancan', '1.13.1'

# Used for error reporting
gem 'rollbar', '2.9.1'

# Used for long running jobs
gem 'resque', '1.24.1'
gem 'resque-scheduler', '2.2.0'
gem 'resque-web', '0.0.7', require: 'resque_web'

# Used for accessing the Highrise API
gem 'highrise', '3.2.3'

# Used for making lists out of active record
gem 'acts_as_list', '0.7.4'

# Used for scopes in index actions in controllers
gem 'has_scope', '0.6.0'

# Used for rich text editor
gem 'active_admin_editor', github: 'ejholmes/active_admin_editor', ref: '86f964be3071cd938c3cd17ad00df94ece3a50c0'

# Used for sending emails
gem 'postmark-rails', '0.12.0'
gem 'recipient_interceptor', '0.1.2'

# Used for connecting to Visual
gem 'activerecord-sqlserver-adapter', '4.2.11'
gem 'tiny_tds', '0.7.0'

# Used for accessing country data
gem 'countries', '1.2.5', require: 'countries/global'

# Used for detecting browser being used
gem 'browser', '2.1.0'

# Used for image processing
gem 'mini_magick', '4.5.1'

# Used for putting react into rails
gem 'react-rails', '1.5.0'
gem 'sprockets-coffee-react', '3.4.1'

# Used for serializing in the API
gem 'active_model_serializers', '0.10.0.rc3'

# Used for color picker
gem 'jquery-minicolors-rails', '2.2.3.0'

# Used for pagination
gem 'kaminari', '0.16.3'
gem 'api-pagination', '4.3.0'

# Used for build URI parameters
gem 'addressable', '2.3.6'

# Used for mocking external requests
gem 'vcr', '3.0.3'
gem 'webmock', '2.1.0'

# Used for nested forms
gem 'cocoon', '1.2.9'

# Used for stripping white space from model attributes
gem 'auto_strip_attributes', '2.1.0'

gem 'hirb'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Rspec for testing
  gem 'rspec-rails', '~> 3.4.2'
  gem 'guard-rspec'

  # Model factories
  gem 'factory_girl', '4.5.0'

  # For DOM testing
  gem 'capybara', '2.5.0'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'

  # For integration testing
  gem 'cucumber-rails', '1.4.3', require: false

  # Test Metadata collection
  gem 'rspec_junit_formatter'
  # For database transactions during testing
  gem 'database_cleaner', '1.5.1'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'

   # Get a better error screen for debugging
  gem 'better_errors', '2.1.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
