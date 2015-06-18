FactoryGirl.define do
  factory :without_text, class: Item do
    list_id 1
  end

  factory :without_list_reference, class: Item do
    text 'Click me > here < to see a discussion on a to-do.'
  end
end