FactoryGirl.define do
  factory :valid_user, class: User do
    email 'some_user@gmail.com'
    password 'some_password'
  end
end
