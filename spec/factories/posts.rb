FactoryGirl.define do
  factory :post do
    author
    category

    title 'Introduction'
    content 'hi, this is introduction'
    posted_at { Time.now }

    trait :publish do
      status 'publish'
    end

    trait :private do
      status 'private'
    end

    trait :draft do
      status 'draft'
    end
  end
end
