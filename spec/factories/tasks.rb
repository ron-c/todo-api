FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Task title - #{n}" }
  end
end
