FactoryBot.define do
  factory :score do
    name { Faker::Lorem.word }
    percentage { Faker::Number.between(from: 0, to: 100) }
    stack_id nil
  end
end