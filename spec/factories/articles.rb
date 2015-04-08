require 'faker'

FactoryGirl.define do
  factory :article do
    title 'Test Post'
    text 'This is a test post!'
  end
end