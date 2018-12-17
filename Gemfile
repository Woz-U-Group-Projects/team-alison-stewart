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
gem 'pg', '~> 1.1', '>= 1.1.3'

# Use Puma as the app server
gem 'puma', '~> 3.12'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0', '>= 5.0.7'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 4.1', '>= 4.1.20'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'

# Use the jquery ui widgets
gem 'jquery-ui-rails', '~> 6.0', '>= 6.0.1'

# Used for full text search
gem 'pg_search', '~> 2.1', '>= 2.1.3'

# Used for SCSS general library
gem 'bourbon', '~> 5.1'

# Used on top of bourbon for basic styling
gem 'neat', '~> 3.0'

# Used for fonts and icons
gem 'font-awesome-sass', '~> 5.5', '>= 5.5.0.1'

# Used for SEO meta tags
gem 'meta-tags', '~> 2.11'

# Used for the admin console
gem 'activeadmin', '~> 1.4', '>= 1.4.3'

# Used for interactive form selects
gem 'select2-rails', '~> 4.0', '>= 4.0.3'

# Used for authorization
gem 'cancancan', '~> 2.3'

# Used for error reporting
gem 'rollbar', '~> 2.18', '>= 2.18.2'

# Used for long running jobs
#gem 'resque', '~> 2.0'
#gem 'resque-scheduler', '~> 4.3', '>= 4.3.1'
#gem 'resque-web', '~> 0.0.12'

# Used for accessing the Highrise API
gem 'highrise', '~> 3.2', '>= 3.2.3'

# Used for making lists out of active record
gem 'acts_as_list', '~> 0.9.17'

# Used for scopes in index actions in controllers
gem 'has_scope', '~> 0.7.2'

# Used for rich text editor
gem 'active_admin_editor', '~> 1.1'

# Used for connecting to Visual
gem 'activerecord-sqlserver-adapter', '~> 5.1', '>= 5.1.6'
#gem 'tiny_tds', '~> 2.1', '>= 2.1.2'

# Used for accessing country data
gem 'countries', '~> 2.2', require: 'countries/global'

# Used for detecting browser being used
gem 'browser', '~> 2.5', '>= 2.5.3'

# Used for image processing
gem 'mini_magick', '~> 4.9', '>= 4.9.2'

# Used for putting react into rails
gem 'react-rails', '~> 2.4', '>= 2.4.7'
gem 'sprockets-coffee-react', '~> 4.0', '>= 4.0.1'

# Used for serializing in the API
gem 'active_model_serializers', '~> 0.10.8'

# Used for color picker
gem 'jquery-minicolors-rails', '~> 2.2', '>= 2.2.6.1'

# Used for pagination
gem 'kaminari', '~> 1.1', '>= 1.1.1'
gem 'api-pagination', '~> 4.8', '>= 4.8.2'

# Used for build URI parameters
gem 'addressable', '~> 2.5', '>= 2.5.2'

# Used for mocking external requests
gem 'vcr', '~> 4.0'
gem 'webmock', '~> 3.4', '>= 3.4.2'

# Used for nested forms
gem 'cocoon', '~> 1.2', '>= 1.2.12'

# Used for stripping white space from model attributes
gem 'auto_strip_attributes', '~> 2.5'
gem 'hirb', '~> 0.7.3'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.8'

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
  gem 'rspec-rails', '~> 3.8', '>= 3.8.1'
  gem 'guard-rspec'

  # Model factories
  #gem 'factory_girl', '~> 4.9'
  gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'

  # For DOM testing
  gem 'capybara', '~> 3.12'
  #gem 'capybara-webkit'
  #gem 'selenium-webdriver', '~> 3.141'
  #gem 'chromedriver-helper'

  # For integration testing
  gem 'cucumber-rails', '~> 1.6', require: false

  # Test Metadata collection
  gem 'rspec_junit_formatter'
  # For database transactions during testing
  gem 'database_cleaner', '~> 1.7'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'

   # Get a better error screen for debugging
  gem 'better_errors', '~> 2.5'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
