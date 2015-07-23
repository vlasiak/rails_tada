FactoryGirl.define do
  factory :valid_user, class: User do
    email 'dave@tada.com'
    password 'QSAkVWduOr56'
  end

  factory :without_email, class: User do
    password 'QSAkVWduOr56'
  end
end
