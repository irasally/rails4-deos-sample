FactoryGirl.define do
  factory :user, aliases: [:follower, :followed]  do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Hello my world!!!"
    user
  end

  factory :relationship do
    follower
    followed
  end
end
