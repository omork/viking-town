require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password "zomg;ad38)(*)"
    password_confirmation :true
  end
end