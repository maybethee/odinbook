FactoryBot.define do
  factory :profile do
    
  end

  factory :relationship do
    follower_id { 1 }
    followed_id { 1 }
  end


  factory :user do
    sequence(:username) { |n| "Joe+#{n}" }
    sequence(:email) { |n| "joe+#{n}@gmail.com" }
    sequence(:password) { |n| "blahblah123+#{n}" }
  end
end