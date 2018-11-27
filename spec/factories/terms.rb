# frozen_string_literal: true

FactoryBot.define do
  factory :term do
    dtstart '2015-05-27 15:01:15'
    dtend '2015-05-27 15:01:15'
    name 'MyString'
  end

  factory :holiday, parent: :term do
    holiday true
  end
end
