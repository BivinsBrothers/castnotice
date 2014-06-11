require "spec_helper"

describe "manage resume" do
  let!(:resume) { create(:resume) }
  let(:user) { resume.user }

  before do
    log_in user
  end

  it 'allows talent to create a resume' do
    union = create(:union)
    accent = create(:accent)
    athletic_endeavor = create(:athletic_endeavor)
    project_type = create(:project_type)
    disability = create(:disability)
    disability_assistive_device = create(:disability_assistive_device)
    ethnicity = create(:ethnicity)
    fluent_language = create(:fluent_language)
    performance_skill = create(:performance_skill)

    visit dashboard_path

    click_link 'dashboard-edit-resume'
    fill_in "resume_phone", with: "1-616-123-4567"
    fill_in "resume_phone_two", with: "1-616-234-9090"
    select "6'3", from: "resume_height"
    fill_in "Weight", with: "140"
    select "Blond", from: "resume_hair_color"
    select "Blue", from: "resume_eye_color"
    fill_in "resume_gender", with: "Female"
    select "Medium", from: "resume_hair_length"
    select "No", from: "resume_piercing"
    select "No", from: "resume_tattoo"
    select "US Citizen", from: "resume_citizen"
    choose("Yes")

    check union.name
    select accent.name, from: "resume_accent_ids"
    select athletic_endeavor.name, from: "resume_athletic_endeavor_ids"
    select disability.name, from: "resume_disability_ids"
    select disability_assistive_device.name, from: "resume_disability_assistive_device_ids"
    select ethnicity.name, from: "resume_ethnicity_ids"
    select fluent_language.name, from: "resume_fluent_language_ids"
    select performance_skill.name, from: "resume_performance_skill_ids"

    fill_in "resume[agent_name]", with: "Awesome Agent"
    fill_in "resume[agent_phone]", with: "1-616-456-7890"
    fill_in "resume[agent_email]", with: "agent@fake.com"
    fill_in "resume[agent_location]", with: "100 Agent St."
    fill_in "resume[agent_location_two]", with: "Villa 2"
    fill_in "resume[agent_city]", with: "Detroit"
    select "Michigan", from: "resume[agent_state]"
    fill_in "resume[agent_zip]", with: "49506"
    select "Theatrical", from: "resume_agent_type"
    fill_in "Manager name", with: "Keith Smith"
    fill_in "Manager phone", with: "1-616-555-1212"
    fill_in "Additional skills", with: "Many years of improve from Disney Stages."
    fill_in "Descriptive Tag", with: "Actor, Dancer, and just plain fabulous!"

    first("input[class=resume-save]").click

    expect(find_field("resume_phone").value).to eq("1-616-123-4567")
    expect(find_field("resume_phone_two").value).to eq("1-616-234-9090")
    expect(find_field("resume_height").value).to eq("75")
    expect(find_field("Weight").value).to eq("140")
    expect(find_field("resume_hair_color").value).to eq("blond")
    expect(find_field("resume_eye_color").value).to eq("blue")
    expect(find_field("resume_agent_name").value).to eq("Awesome Agent")
    expect(find_field("resume_agent_phone").value).to eq("1-616-456-7890")
    expect(find_field("resume_agent_email").value).to eq("agent@fake.com")
    expect(find_field("resume_agent_location").value).to eq("100 Agent St.")
    expect(find_field("resume_agent_location_two").value).to eq("Villa 2")
    expect(find_field("resume_agent_city").value).to eq("Detroit")
    expect(find_field("resume_agent_zip").value).to eq("49506")
    expect(find_field("resume_manager_name").value).to eq("Keith Smith")
    expect(find_field("resume_manager_phone").value).to eq("1-616-555-1212")
    expect(find_field("resume_additional_skills").value).to eq("Many years of improve from Disney Stages.")
    expect(find_field("resume_descriptive_tag").value).to eq("Actor, Dancer, and just plain fabulous!")

    expect(find_field("resume_gender").value).to eq("Female")
    expect(find_field("resume_hair_length").value).to eq("medium")
    expect(find_field("resume_piercing").value).to eq("no")
    expect(find_field("resume_tattoo").value).to eq("no")
    expect(find_field("resume_citizen").value).to eq("us citizen")
    expect(find_field("resume_passport_true")).to be_checked

    click_link "Add a project"

    select "Episodic", from: "Project Type"
    fill_in "Title", with: "Gossip Girl"
    fill_in "Role", with: "Blair"
    fill_in "Director/Studio", with: "Star Studios"

    click_button "Save Project"

    visit resume_path

    expect(page).to have_content("Episodic")
    expect(page).to have_content(union.name)
    expect(page).to have_content(accent.name)
    expect(page).to have_content(athletic_endeavor.name)
    expect(page).to have_content(disability.name)
    expect(page).to have_content(disability_assistive_device.name)
    expect(page).to have_content(ethnicity.name)
    expect(page).to have_content(fluent_language.name)
    expect(page).to have_content(performance_skill.name)
    expect(page).to have_content("Gossip Girl")
    expect(page).to have_content("Blair")
    expect(page).to have_content("Star Studios")


  end

  it 'allows talent to edit a resume' do
    visit dashboard_path

    click_link('dashboard-edit-resume')

    expect(find_field("resume_phone").value).to eq("1-616-555-4567")
    expect(find_field("resume_phone_two").value).to eq("1-616-234-9090")
    expect(find_field("Weight").value).to eq("140")
    expect(find_field("resume_hair_color").value).to eq("blond")
    expect(find_field("resume_eye_color").value).to eq("blue")
    expect(find_field("resume_agent_name").value).to eq("Awesome Agent")
    expect(find_field("resume_agent_phone").value).to eq("1-616-667-8989")
    expect(find_field("resume_manager_name").value).to eq("Keith Smith")
    expect(find_field("resume_manager_phone").value).to eq("1-616-222-3333")

    expect(find_field("resume_descriptive_tag").value).to eq("Dancer, Actor")

    select "5'10", from: "resume_height"
    fill_in "Weight", with: "155"
    select "Brown", from: "resume_hair_color"
    select "Green", from: "resume_eye_color"
    fill_in "Descriptive Tag", with: "Singer"

    find(".resume-save").click

    expect(find_field("resume_height").value).to eq("70")
    expect(find_field("resume_weight").value).to eq("155")
    expect(find_field("resume_hair_color").value).to eq("brown")
    expect(find_field("resume_eye_color").value).to eq("green")
    expect(find_field("resume_descriptive_tag").value).to eq("Singer")
  end

  it "allows the user to choose new slug when duplicate found" do
    create(:resume, {slug: "test"})

    visit edit_resume_path

    fill_in "Public Resume URL", with: "test"

    find(".resume-save").click

    expect(page.text).to include("Slug has already been taken")

    fill_in "Public Resume URL", with: "something-else"

    find(".resume-save").click

    expect(find_field("resume_slug").value).to eq("something-else")
  end

  it "a user can upload a headshot", :js => true do
    visit dashboard_path

    click_link "dashboard-edit-resume"

    click_link "Add a photo"

    attach_file "headshot_image", "#{Rails.root}/spec/fixtures/image.jpg"

    expect {
      click_button "Save Photo"
    }.to change {
      resume.headshots.count
    }.from(0).to(1)
  end

  it "allows adding videos", :js => true do
    visit dashboard_path

    click_link "dashboard-edit-resume"

    click_link "Add a video"

    fill_in "video_video_url", with: "http://www.youtube.com/watch?v=2kn8im8XOwM"

    expect {
      click_button "Save Video"
    }.to change {
      user.resume.videos.count
    }.from(0).to(1)

    expect(page).to have_content("Delete")
  end

  it "allow deleting videos" do
    create(:video, resume: resume)

    visit dashboard_path

    click_link "dashboard-edit-resume"

    expect {
      click_link "Delete"
    }.to change {
      Dom::Video.all.count
    }.from(1).to(0)
  end

  it "allows adding project" do
    create(:project_type, name: "Industrial Project")

    visit dashboard_path

    click_link "dashboard-edit-resume"

    click_link "Add a project"

    select "Industrial Project", from: "Project Type"
    fill_in "Title", with: "Once Upon A Time"
    fill_in "Role", with: "Cinderella"
    fill_in "Director/Studio", with: "Disney Studios"

    click_button "Save Project"

    expect(page).to have_content("Industrial Project")
    expect(page).to have_content("Once Upon A Time")
    expect(page).to have_content("Cinderella")
    expect(page).to have_content("Disney Studios")
  end

  it "allows editing/deleting a project" do
    create(:project, resume: resume)
    create(:project_type, name: "Industrial Project")

    visit dashboard_path
    click_link "dashboard-edit-resume"

    expect(page).to have_content("Industrial Project")
    expect(page).to have_content("Wizzard of OZ")
    expect(page).to have_content("Dorothy")
    expect(page).to have_content("Disney Studios")

    click_link "Edit"

    select "Industrial Project", from: "Project Type"
    fill_in "Title", with: "Ford Pickup"
    fill_in "Role", with: "Driver"
    fill_in "Director/Studio", with: "Ford Studios"

    click_button "Save"

    expect(page).to have_content("Ford Pickup")
    expect(page).to have_content("Driver")
    expect(page).to have_content("Ford Studios")

    click_link "Delete"

    expect(page).to_not have_content("Ford Pickup")
    expect(page).to_not have_content("Driver")
    expect(page).to_not have_content("Ford Studios")

  end

  it "allows adding a school" do
    create(:resume, user: user)

    visit dashboard_path

    click_link "dashboard-edit-resume"

    click_link "Add a school"
    select "College", from: "Education Type"
    fill_in "School", with: "Michigan Tech"
    fill_in "Major", with: "Computer Science"
    fill_in "Degree", with: "Masters"

    click_button "Save School"

    expect(page).to have_content("College")
    expect(page).to have_content("Michigan Tech")
    expect(page).to have_content("Computer Science")
    expect(page).to have_content("Masters")
  end

  it "allows editing/deleting a school" do
    create(:school, resume: resume)

    visit dashboard_path

    click_link "dashboard-edit-resume"

    expect(page).to have_content("University")
    expect(page).to have_content("University of Michigan")
    expect(page).to have_content("Acting")
    expect(page).to have_content("Associates Degree in Creative Dance")

    click_link "Edit"

    select "College", from: "Education Type"
    fill_in "School", with: "Michigan Tech"
    fill_in "Major", with: "Computer Science"
    fill_in "Degree", with: "Masters"

    click_button "Save"

    expect(page).to have_content("Michigan Tech")
    expect(page).to have_content("Computer Science")
    expect(page).to have_content("Masters")

    click_link "Delete"

    expect(page).to_not have_content("Michigan Tech")
    expect(page).to_not have_content("Computer Science")
    expect(page).to_not have_content("Masters")
  end

  it "talent can add a custom slug to their public profile" do
    visit edit_resume_path

    fill_in "Public Resume URL", with: "castnotice"
    find(".resume-save").click

    visit dashboard_path
    expect(page).to have_content("Your public resume URL: http://www.example.com/r/castnotice")

    log_out
    enter_promo_code

    visit public_resume_path("castnotice")

    expect(page).to have_content(user.name)
  end
end
