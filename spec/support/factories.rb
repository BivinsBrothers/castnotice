FactoryGirl.define do

  factory :video do
    user
    video_url "http://www.youtube.com/watch?v=m8u8Z3bUQfs"
    video_thumb_url "https://img.youtube.com/vi/m8u8Z3bUQfs/0.jpg"
  end

  factory :headshot do
    user
    image {File.new(File.join(Rails.root, 'spec', 'fixtures', 'image.jpg'))}
  end

  factory :user do
    name "Test Dummy"
    email "test@fake.com"
    password "goodpassword"
    birthday "1969-1-1"
    tos "1"

    trait :admin do
      admin true
    end
  end

  factory :school do
    education_type "University"
    school "University of Michigan"
    major "Acting"
    degree "Associates Degree in Creative Dance"
  end

  factory :resume do
    height 69
    weight 140
    hair_color "blond"
    eye_color "blue"
    phone "1-616-555-4567"
    phone_two "1-616-234-9090"
    unions ["Awesome Union"]
    agent_name "Awesome Agent"
    agent_phone "1-616-667-8989"
    agent_email "agenttest@fake.com"
    agent_location "100 Grandville"
    agent_location_two "Apt. 1"
    agent_city "Grand Rapids"
    agent_state "Michigan"
    agent_zip "49505"
    manager_name "Keith Smith"
    manager_phone "1-616-222-3333"
    additional_skills "Improve"
    descriptive_tag "Dancer, Actor"
  end

  factory :project do
    project_type "Film Project"
    title "Wizzard of OZ"
    role "Dorothy"
    director_studio "Disney Studios"
  end

  factory :event do
    name "Big Event"
    project_type "Cable"
    region
    performer_type "That Guy"
    character "This Guy"
    pay "$6.00"
    union "GVSU"
    director "The other guy"
    story "All the things!"
    description "Build all the things"
    audition "Don't cry"
    audition_date 7.days.from_now
    start_date 1.month.from_now
    end_date 2.months.from_now

    trait :paid do
      paid true
    end
  end

  # Category Factories

  factory :region do
    name "Central"
  end
end
