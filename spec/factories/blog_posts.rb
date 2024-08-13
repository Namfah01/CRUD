FactoryBot.define do
  factory :blog_post do
    title { "Hello Ruby" }
    body { "How are you" }
    association :user
  end
end
