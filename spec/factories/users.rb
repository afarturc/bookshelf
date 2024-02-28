FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    is_admin { false }
    email { "#{first_name}.#{last_name}@test.com" }
    password { "password" }
  end
end
