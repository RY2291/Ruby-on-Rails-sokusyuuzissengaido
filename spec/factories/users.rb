FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    email { "test1@test.com" }
    password { "password" }
  end
end