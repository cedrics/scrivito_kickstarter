ENV['RAILS_ENV'] = 'test'

# Copy config files to dummy app! This has to be done before the
# rails env is loaded
require File.expand_path('../../lib/scrival_kickstarter/rake/configuration_helper', __FILE__)
dummy_config_path = File.expand_path('../dummy/config', __FILE__)
ScrivalKickstarter::Rake::ConfigurationHelper.new(dummy_config_path).copy

require File.expand_path('../dummy/config/environment.rb', __FILE__)
require 'rspec/rails'

require 'support/test_destination_root'

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.infer_base_class_for_anonymous_controllers = false
  config.filter_run :focus
  config.mock_with :rspec
  config.order = :random
end
