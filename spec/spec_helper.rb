Dir["app/logic/**/*.rb"].each {|file| require_relative "../#{file}" }

RSpec.configure do |config|
  # Define qual o framework de mocks.
  # Pode ser :rspec, :mocha, :rr, :flexmock, :none
  config.mock_framework = :rspec
  # Exibe backtrace completo caso algum exemplo falhe.
  config.full_backtrace = true
end
