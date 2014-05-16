FactoryGirl.define do

  factory :video do
    resume
    video_url "http://www.youtube.com/watch?v=m8u8Z3bUQfs"
    video_thumb_url "https://img.youtube.com/vi/m8u8Z3bUQfs/0.jpg"
  end

  factory :headshot do
    resume
    image {File.new(File.join(Rails.root, 'spec', 'fixtures', 'image.jpg'))}
  end

  factory :user do
    name "Test Dummy"
    sequence(:email) {|n| "test#{n}@fake.com" }
    password "goodpassword"
    birthday 27.years.ago
    tos "1"

    trait :admin do
      admin true
    end

    trait :with_parent do
      parent_name "Joe Boxer"
      parent_email "parent@fake.com"
      parent_location "Narnia"
      parent_city "Elsewhere"
      parent_state "Awesome"
      parent_zip "12345"
      parent_phone "5551231234"
    end

    after(:build) do |user|
      create(:resume, user: user) if user.resume.nil?
    end
  end

  factory :resume do
    height 69
    weight 140
    hair_color "blond"
    eye_color "blue"
    phone "1-616-555-4567"
    phone_two "1-616-234-9090"
    unions { [create(:union, name: "Awesome Union")] }
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

    after(:build) do |resume|
      create(:user, resume: resume) if resume.user.nil?
    end
  end

  factory :school do
    education_type "University"
    school "University of Michigan"
    major "Acting"
    degree "Associates Degree in Creative Dance"
  end

  factory :project do
    project_type
    title "Wizzard of OZ"
    role "Dorothy"
    director_studio "Disney Studios"
  end

  factory :event do
    project_title "Big Event"
    project_type
    region
    unions { [create(:union)] }
    audition_date Date.today
    gender "Male"

    trait :full do
      storyline "Eurovision"
      character_description "Austrian in drag"
      how_to_audition "Grow a beard"
      start_date 2.months.from_now
      location "Stockholm"
      casting_director "That guy"
      project_type_details "It involves people"
      special_notes "Avoid the caviar"
    end

    trait :paid do
      paid true
    end
  end

  # Category Factories

  factory :region do
    name "Central"
  end

  factory :project_type do
    name "Episodic"
  end

  factory :union do
    name "UEA"
  end
end
