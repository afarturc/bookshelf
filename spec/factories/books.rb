FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    cover_url { FFaker::Book.cover }
    genre { Book.genres.keys.sample }
  end
end
