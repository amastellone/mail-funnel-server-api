FactoryGirl.define do
  factory :app do
    name { Faker::Company.name }
    api_key nil
    api_secret { Faker::Code.imei}
    builder_lock false
    auth_token { Faker::Code.imei}
  end
end
