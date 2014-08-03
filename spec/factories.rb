FactoryGirl.define do
  factory :user, class: User do
    name "Stefan Huynh"
    email "huynh.stefan@gmail.com"
    password "123456"
    password_confirmation "123456"
  end
end