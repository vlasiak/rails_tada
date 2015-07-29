FactoryGirl.define do
  factory :with_valid_attributes, class: Item do
    text '< Click the box to my left to check me off as done.'
    list_id 1
  end

  factory :without_text, class: Item do
    list_id 1
  end

  factory :without_list_reference, class: Item do
    text 'Click me > here < to see a discussion on a to-do.'
  end

  factory :only_with_list_reference, class: Item do
    list_id 1
  end

  factory :completed_today, class: Item do
    text 'Read this book again'
    list_id 1
    done true
    completed_at Date.today
  end

end