# frozen_string_literal: true

# This will guess the User class
FactoryBot.define do
  factory :post do
    title { FFaker::Book.title }
    body  { FFaker::Book.description }
  end
end
