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
    unions ["Awesome Union"]
    agent_name "Awesome Agent"
    agent_phone "1-616-667-8989"
    additional_skills "Improve"
    descriptive_tag "Dancer, Actor"
  end

  factory :project do
    project_type "Film Project"
    title "Wizzard of OZ"
    role "Dorothy"
    director_studio "Disney Studios"
  end
end