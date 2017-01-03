FactoryGirl.define do
  factory :email do
    email_address {Faker::Internet.email}
    name {Faker::Name.first_name}
    app_id nil
    email_list_id nil
  end
end
