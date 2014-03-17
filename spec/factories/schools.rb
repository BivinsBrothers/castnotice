# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school do
    education_type "University"
    school "University of Michigan"
    major "Acting"
    degree "Associates Degree in Creative Dance"
  end
end
