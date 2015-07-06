FactoryGirl.define do
  factory :without_title, class: List do
    description 'Explore Basecamp! — To-do list basics'
  end

  factory :with_same_title, class: List do
    title 'Explore Basecamp! — Some quick things to explore in Basecamp'
  end

  factory :empty_list, class: List do end

  factory :with_items, class: List do
    id 1
    title 'Some quick things to explore in Basecamp'
    description 'To-do list basics'
  end
end