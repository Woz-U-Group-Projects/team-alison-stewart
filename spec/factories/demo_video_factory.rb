FactoryGirl.define do
  factory :demo_video do
    event_type

    sequence(:title) { |n| "title-#{n}" }
    sequence(:description) { |n| "description-#{n}" }
    sequence(:video_url) { |n| "video_url-#{n}" }
  end
end
