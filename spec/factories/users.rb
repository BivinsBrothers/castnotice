FactoryGirl.define do
  factory :user do
    name "Test Dummy"
    email "test@fake.com"
    password "goodpassword"
    birthday "1969-1-1"
    tos "1"
  end
end
