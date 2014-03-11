require "spec_helper"

describe "manage resume" do
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
    select "University", from: "resume_form_schools_attributes_0_education_type"
    fill_in "resume_form_schools_attributes_0_school", with: "University of Acting"
    fill_in "resume_form_schools_attributes_0_major", with: "Acting"
    fill_in "resume_form_schools_attributes_0_degree", with: "Bachlers in Acting"

    click_button "Save"

    expect(page).to have_content("Dashboard")
    expect(page).to have_content("1-616-123-4567")
    expect(page).to have_content("140")
    expect(page).to have_content("blond")
    expect(page).to have_content("blue")
    expect(page).to have_content("Screen Actors Guild")
    expect(page).to have_content("Awesome Agent")
    expect(page).to have_content("1-616-456-7890")
    expect(page).to have_content("Many years of improve from Disney Stages.")
  end

  it 'allows talent to edit a resume' do
    user = create(:user, name: "New Name")

    resume = create(:resume, {
      user: user,
      height: 73,
      weight: 140,
      phone: "1-616-123-4567",
      hair_color: "blond",
      eye_color: "blue",
      unions: "Screen Actors Guild",
      agent_name: "Awesome Agent",
      agent_phone: "1-616-456-7890",
      additional_skills: "Many years of improve from Disney Stages.",
    })

    log_in user

    visit dashboard_path
    click_link('Edit My Close Up')
    expect(page).to have_content('Edit My Close Up')

    expect(find_field("Name").value).to eq("New Name")
    expect(find_field("Email").value).to eq("test@fake.com")
    expect(find_field("Phone").value).to eq("1-616-123-4567")
    expect(find_field("Weight").value).to eq("140")
    expect(find_field("resume_form_height_feet").value).to eq("6")
    expect(find_field("resume_form_height_inches").value).to eq("1")
    expect(find_field("resume_form_hair_color").value).to eq("blond")
    expect(find_field("resume_form_eye_color").value).to eq("blue")
    expect(find_field("resume_form_agent_name").value).to eq("Awesome Agent")
    expect(find_field("resume_form_agent_phone").value).to eq("1-616-456-7890")
    expect(find_field("resume_form_additional_skills").value).to eq("Many years of improve from Disney Stages.")

    select "5", from: "resume_form_height_feet"
    select "9", from: "resume_form_height_inches"
    fill_in "Weight", with: "155"
    select "Brown", from: "resume_form_hair_color"
    select "Green", from: "resume_form_eye_color"

    click_button "Save"

    expect(page).to have_link("Edit My Close Up")
    resume.reload

    expect(page).to have_content(69)
    expect(page).to have_content(155)
    expect(page).to have_content("brown")
    expect(page).to have_content("green")
  end

  it "displays validation errors for required attributes" do
    user = create(:user)
    log_in user

    visit dashboard_path
    click_link "Create Resume"

    fill_in "Name", with: ""
    fill_in "Email", with: ""
    fill_in "Phone", with: ""

    click_button "Save"

    expect(page).to have_content("Edit My Close Up")

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Phone can't be blank")
  end

  it "allows adding project" do
    user = create(:user)
    create(:resume, user: user)
    log_in user

    visit dashboard_path
    click_link "New Project"

    select "Film Project", from: "Project Type"
    fill_in "Title", with: "Once Upon A Time"
    fill_in "Role", with: "Cinderella"
    fill_in "Director/Studio", with: "Disney Studios"

    click_button "Create Project"

    expect(page).to have_content("Film Project")
    expect(page).to have_content("Once Upon A Time")
    expect(page).to have_content("Cinderella")
    expect(page).to have_content("Disney Studios")

  end

  it "allows editing a project" do
    user = create(:user)
    create(:resume, user: user)
    create(:project, user: user)

    log_in user

    visit dashboard_path

    click_link 'Edit Project'

    select "Industrial Project", from: "Project Type"
    fill_in "Title", with: "Industrial"
    fill_in "Role", with: "Gopher"
    fill_in "Director/Studio", with: "Tin Cup"

    click_button "Update Project"

    expect(page).to have_content("Industrial Project")
    expect(page).to have_content("Industrial")
    expect(page).to have_content("Gopher")
    expect(page).to have_content("Tin Cup")

  end
end

