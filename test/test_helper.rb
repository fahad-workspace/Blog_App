require 'simplecov'

SimpleCov.start 'rails'

class ActionController::TestCase
  include Devise::TestHelpers
end