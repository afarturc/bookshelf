FactoryBot.define do
  factory :user do
    first_name { "test" }
    last_name { "user" }
    is_admin { false }
    email { "#{first_name}.#{last_name}@test.com" }
    password { "password" }
  end
end
