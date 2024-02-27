FactoryBot.define do
  factory :reservation do
    book
    user
    returned_on { nil }
  end
end
