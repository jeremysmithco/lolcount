RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'twitter', :version => '0.9.12'
  config.gem 'twitter-text', :version => '1.2.2'
  config.gem 'whenever', :version => '0.5.3'
  
  config.time_zone = 'UTC'
end