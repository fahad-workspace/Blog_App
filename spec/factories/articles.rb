require 'faker'

FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.characters(7) }
    text { Faker::Lorem.sentence }
  end
end