require "spec_helper"

describe "resume creation" do
  it 'allows talent to create a resume' do
    user = create(:user)
    log_in user

    visit dashboard_path

    click_link('Create Resume')
    expect(page).to have_content('My Close Up')

    fill_in "Name", with: "Test Dummy"
    fill_in "Email", with: "test@fake.com"
    fill_in "Phone", with: "1-616-123-4567"
    select "17", from: "resume_form_birthday_3i"
    select "September", from: "resume_form_birthday_2i"
    select "1987", from: "resume_form_birthday_1i"
    select "6", from: "resume_form_height_feet"
    select "1", from: "resume_form_height_inches"
    fill_in "Weight", with: "140"
    select "Blond", from: "resume_form_hair_color"
    select "Blue", from: "resume_form_eye_color"
    check "Screen Actors Guild"
    fill_in "Agent name", with: "Awesome Agent"
    fill_in "Agent phone", with: "1-616-456-7890"
    fill_in "Additional skills", with: "Many years of improve from Disney Stages."

    click_button "Save"

    resume = Resume.last

    expect(resume.phone).to eq("1-616-123-4567")
    expect(resume.weight).to eq(140)
    expect(resume.hair_color).to eq("blond")
    expect(resume.eye_color).to eq("blue")
    expect(resume.unions).to eq(["Screen Actors Guild", ""])
    expect(resume.agent_name).to eq("Awesome Agent")
    expect(resume.agent_phone).to eq("1-616-456-7890")
    expect(resume.additional_skills).to eq("Many years of improve from Disney Stages.")

    expect(page).to have_link("Edit Resume")
  end
end
