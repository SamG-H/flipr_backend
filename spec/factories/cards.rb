FactoryBot.define do
  factory :card do
    front { Faker::Lorem.word }
    back { Faker::Lorem.word }
    stack_id nil
  end
end