FactoryBot.define do
  factory :tag do
    sequence(:title) { |n| "Tag title - #{n}" }
  end
end
