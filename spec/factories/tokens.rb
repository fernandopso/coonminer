# frozen_string_literal: true

FactoryBot.define do
  factory :token do
    word { 'Brasil' }
    lang { 'all' }
  end
end
