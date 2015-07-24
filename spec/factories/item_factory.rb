FactoryGirl.define do
  factory :item do
    sequence(:title) { |n| Faker::Lorem.word + n.to_s }
    kind "Help"
    date Date.today

    association :standup
  end

  factory :event, parent: :item do
    kind "Event"
  end

  factory :new_face, class: Item do
    sequence(:title) { |n| Faker::Lorem.word + n.to_s }
    kind "New face"
    date Date.today

    association :standup
  end
end
