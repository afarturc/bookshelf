FactoryBot.define do
  factory :book do
    title { "Test Book" }
    description { "This book is only for testing" }
    cover_url { "default_cover.png" }
    genre { 0 }
  end
end
