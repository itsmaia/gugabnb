# frozen_string_literal: true

FactoryBot.define do
  factory :wish do
    wished { false }
    user { nil }
    listing { nil }
  end
end
