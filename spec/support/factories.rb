FactoryGirl.define do
  factory :video do
    association :videoable, factory: :resume
    video_url "http://www.youtube.com/watch?v=m8u8Z3bUQfs"
    video_thumb_url "https://img.youtube.com/vi/m8u8Z3bUQfs/0.jpg"
  end

  factory :headshot do
    association :imageable, factory: :resume
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

    trait :mentor do
      mentor true
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
    eye_color "blue"
    hair_color "red"
    hair_length "long"
    piercing "yes"
    tattoo "no"
    citizen "us_citizen"
    agent_type "television"

    after(:build) do |resume|
      create(:user, resume: resume) if resume.user.nil?
    end
  end

  factory :critique do
    user
    project_title "Chicago"
    types ["dance", "voice"]
    notes "What could I improve on?"

    trait :closed do
      after(:create) do |c|
        c.response = create(:critique_response)
        c.save
      end
    end
  end

  factory :critique_response do
    user
    body "Looks Great!!!"
  end

  factory :school do
    education_type "university"
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
    transient do
      audition_date Date.today
    end

    project_title "Big Event"
    project_type
    region
    unions { [create(:union)] }
    casting_director "That guy"
    production_location "Glasgow"
    pay_rate "$5,000 - $10,000"
    staff "Some random staff listings"
    location "Stockholm"
    how_to_audition "Grow a beard"

    after(:create) do |event, evaluator|
      create(:event_audition_date, audition_date: evaluator.audition_date, event: event)
    end

    trait :full do
      storyline "Eurovision"
      start_date 2.months.from_now
      end_date 3.months.from_now
      special_notes "Avoid the caviar"
    end

    trait :paid do
      paid true
    end
  end

  factory :event_audition_date do
    audition_date Date.today
  end

  factory :region do
    name "Central"
  end

  factory :project_type do
    name "Episodic"
  end

  factory :union do
    name "UEA"
  end

  factory :accent do
    name "French"
  end

  factory :athletic_endeavor do
    name "Hang Gliding"
  end

  factory :disability do
    name "Autism"
  end

  factory :disability_assistive_device do
    name "Crutches: Forearm"
  end

  factory :ethnicity do
    name "Mixed"
  end

  factory :fluent_language do
    name "Mandarin"
  end

  factory :performance_skill do
    name "Ballet"
    category "dancer"
  end

  factory :conversation do
    association :recipient, factory: :user
    association :sender, factory: :user
    subject "Building a Hamburger"

    trait :with_message do
      messages { [create(:message)] }
    end
  end

  factory :message do
    conversation
    body "Something important"

    before(:create) do |message|
      message.recipient ||= message.conversation.recipient
      message.sender ||= message.conversation.sender
    end
  end

  factory :role do
    description "description"
    gender "gender"
    age_min 1
    age_max 20
    event
  end
end
