FactoryBot.define do
  factory :blog_post do
    title { "Sample Title" }
    body { "Sample Body" }
    association :user
  end
end

