source 'http://rubygems.org'
source 'http://gemcutter.org'

gem 'rails', '3.0.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'paperclip'

# Needed for background video conversion
gem 'delayed_job'
gem 'delayed_paperclip'
gem 'daemons'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
gem 'sqlite3-ruby','1.3.3', :require => 'sqlite3'
gem 'gravatar_image_tag', '1.0.0.pre2'
gem 'will_paginate', '3.0.pre2'


# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

group :test do
  gem 'webrat', '0.7.1'
  gem 'factory_girl_rails', '1.0'

end


# http://relishapp.com/rspec/rspec-rails/v/2-4
group :test, :development do
  gem "rspec-rails", "~> 2.4"
  gem "annotate-models", '1.0.4'
  gem 'faker', '0.3.1'
end
