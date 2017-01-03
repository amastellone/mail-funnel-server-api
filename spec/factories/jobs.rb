FactoryGirl.define do
  factory :job do
    subject "MyString"
    content "MyText"
    email_list_id nil
    app_id nil
    client_campaign 1
    executed false
    execute_time 1
    hook_identifier "MyString"
    execute_frequency "MyString"
    name "MyString"
  end
end
