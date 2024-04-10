FactoryBot.define do
  factory :api_key do
    access_token { SecureRandom.hex }
    active { true }
    user_id { 1 }
  end
end
