require 'rspec'

FOLDERS_MAP = -> (folders) do
  File.join(File.dirname(__FILE__), "#{folders}", "**/*.rb")
end

RSpec.configure do |config|
  config.order = 'random'
  config.formatter = :documentation

  Dir[FOLDERS_MAP.call('lib')].each { |f| require f }
  Dir[FOLDERS_MAP.call('service')].each { |f| require f }
end