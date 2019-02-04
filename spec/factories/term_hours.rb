# frozen_string_literal: true

FactoryBot.define do
  factory :term_hour do
    term
    location
    data { 'MyText' }
  end
end
