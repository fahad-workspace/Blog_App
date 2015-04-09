require 'faker'

FactoryGirl.define do
  factory :comment do
    commenter { Faker::Name.name }
    body { Faker::Lorem.sentence }
  end
end