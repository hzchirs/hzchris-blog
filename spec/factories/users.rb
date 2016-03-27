FactoryGirl.define do
  factory :user, aliases: [:author] do
    name "Chris"
    sequence(:email) { |n| "#{name}-#{n}@example.com" }
    password "passw0rd"
    password_confirmation "passw0rd"

    trait :admin do
      role "admin"
    end

    trait :normal do
      role "normal"
    end

    trait :other do
      name "John"
      role "normal"
    end

    trait :with_public_posts do
      after(:create) do |user|
        create_list :post, 2, :publish, author: user
      end
    end

    trait :with_private_posts do
      after(:create) do |user|
        create_list :post, 2, :private, author: user
      end
    end
  end
end
