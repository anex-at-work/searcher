# frozen_string_literal: true

FactoryBot.define do
  factory :language do
    sequence :name do
      Faker::ProgrammingLanguage.name
    end

    sequence :type do
      Faker::Lorem.words((2..6).to_a.sample, true).join(', ')
    end

    sequence :designed_by do
      Faker::ProgrammingLanguage.creator
    end
  end
end
