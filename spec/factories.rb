FactoryBot.define do
  factory :profile do
    
  end

  factory :relationship do
    follower_id { 1 }
    followed_id { 1 }
  end


  factory :user do
    username { "Joe" }
    email { "joe@gmail.com" }
    password { "blahblah123" }
  end
end