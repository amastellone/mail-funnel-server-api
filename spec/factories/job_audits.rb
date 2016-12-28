FactoryGirl.define do
  factory :job_audit do
    job nil
    time_sent ""
    recipient "MyString"
    subject "MyString"
    content "MyText"
  end
end
