# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    trait :valid do
      email { 'ny@selise.ch' }
      password { 'Alberto@1729' }
      password_confirmation { 'Alberto@1729' }
    end

    trait :invalid do
      password { Faker::Internet.password }
    end

    after(:create) do |user|
      create(:profile, user: user)
    end
  end
end
