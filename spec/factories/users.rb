FactoryBot.define do
  factory :user do
    factory :random_user do
      email { 'bar@foo.com' }
      password { 'password' }
      password_confirmation { 'password' }
      created_at { Time.now }
      updated_at { nil }
    end

    factory :authenticated_user do
      email { 'user@authenticated.com' }
      password { 'password' }
      password_confirmation { 'password' }
      created_at { Time.now }
      updated_at { nil }
    end
  end
end
