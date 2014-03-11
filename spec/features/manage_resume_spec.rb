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
    select "Film Project", from: "resume_form_projects_attributes_0_project_type"
    fill_in "resume_form_projects_attributes_0_title", with: "Once Upon A Time"
    fill_in "resume_form_projects_attributes_0_role", with: "Cinderella"
    fill_in "resume_form_projects_attributes_0_director_studio", with: "Disney Studios"

    click_button "Save"

    expect(user.resume.phone).to eq("1-616-123-4567")
    expect(user.resume.weight).to eq(140)
    expect(user.resume.hair_color).to eq("blond")
    expect(user.resume.eye_color).to eq("blue")
    expect(user.resume.unions).to eq(["Screen Actors Guild", ""])
    expect(user.resume.agent_name).to eq("Awesome Agent")
    expect(user.resume.agent_phone).to eq("1-616-456-7890")
    expect(user.resume.additional_skills).to eq("Many years of improve from Disney Stages.")
    expect(user.projects.last.project_type).to eq("film")
    expect(user.projects.last.title).to eq("Once Upon A Time")
    expect(user.projects.last.role).to eq("Cinderella")
    expect(user.projects.last.director_studio).to eq("Disney Studios")


    expect(page).to have_link("Edit Resume")

    click_link "Edit Resume"
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

    project = create(:project, {
      user: user,
      project_type: "Film Project",
      title: "Once Upon A Time",
      role: "Cinderella",
      director_studio: "Disney Studios"
    })

    log_in user

    visit dashboard_path
    click_link('Edit Resume')
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
    expect(find_field("resume_form_projects_attributes_0_project_type").value).to eq("film")
    expect(find_field("resume_form_projects_attributes_0_title").value).to eq("Once Upon A Time")
    expect(find_field("resume_form_projects_attributes_0_role").value).to eq("Cinderella")
    expect(find_field("resume_form_projects_attributes_0_director_studio").value).to eq("Disney Studios")

    select "5", from: "resume_form_height_feet"
    select "9", from: "resume_form_height_inches"
    fill_in "Weight", with: "155"
    select "Brown", from: "resume_form_hair_color"
    select "Green", from: "resume_form_eye_color"
    select "Television Project", from: "resume_form_projects_attributes_0_project_type"
    fill_in "resume_form_projects_attributes_0_title", with: "Big Love"
    fill_in "resume_form_projects_attributes_0_role", with: "Big"
    fill_in "resume_form_projects_attributes_0_director_studio", with: "Showtime"

    click_button "Save"

    expect(page).to have_link("Edit Resume")
    resume.reload

    expect(resume.height).to eq(69)
    expect(resume.weight).to eq(155)
    expect(resume.hair_color).to eq("brown")
    expect(resume.eye_color).to eq("green")
    expect(user.projects.last.project_type).to eq("television")
    expect(user.projects.last.title).to eq("Big Love")
    expect(user.projects.last.role).to eq("Big")
    expect(user.projects.last.director_studio).to eq("Showtime")

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
end

