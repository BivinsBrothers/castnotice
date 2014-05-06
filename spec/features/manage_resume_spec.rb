require "spec_helper"

describe "manage resume" do
  it 'allows talent to create a resume' do
    user = create(:user)
    create(:union, name: "Screen Actors Guild")
    create(:project_type, name: "Television")

    log_in user
    visit dashboard_path

    click_link 'dashboard-edit-resume'
    fill_in "resume_phone", with: "1-616-123-4567"
    fill_in "resume_phone_two", with: "1-616-234-9090"
    select "6'3", from: "resume_height"
    fill_in "Weight", with: "140"
    select "Blond", from: "resume_hair_color"
    select "Blue", from: "resume_eye_color"
    select "Female", from: "resume_gender"
    select "Medium", from: "resume_hair_length"
    select "No", from: "resume_piercing"
    select "No", from: "resume_tattoo"
    select "US Citizen", from: "resume_citizen"
    choose("Yes")

    check "Screen Actors Guild"

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

    expect(find_field("resume_gender").value).to eq("female")
    expect(find_field("resume_hair_length").value).to eq("medium")
    expect(find_field("resume_piercing").value).to eq("no")
    expect(find_field("resume_tattoo").value).to eq("no")
    expect(find_field("resume_citizen").value).to eq("us citizen")
    expect(find_field("resume_passport_true")).to be_checked

    click_link "Add a project"

    select "Television", from: "Project Type"
    fill_in "Title", with: "Gossip Girl"
    fill_in "Role", with: "Blair"
    fill_in "Director/Studio", with: "Star Studios"

    click_button "Save Project"

    expect(page).to have_content("Television")
    expect(page).to have_content("Gossip Girl")
    expect(page).to have_content("Blair")
    expect(page).to have_content("Star Studios")

  end

  it 'allows talent to edit a resume' do
    user = create(:user, name: "New Name")
    create(:resume, user: user)

    log_in user
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

  it "a user can upload a headshot", :js => true do
    user = create(:user)

    log_in user
    visit dashboard_path

    click_link "dashboard-edit-resume"

    expect(page).to have_content("Add Head Shot")

    click_link "Add Head Shot"

    attach_file "headshot_image", "#{Rails.root}/spec/fixtures/image.jpg"

    expect {
      click_button "Upload Head Shot"
    }.to change {
      user.headshots.count
    }.from(0).to(1)
  end

  it "allows adding videos", :js => true do
    user = create(:user)
    create(:resume, user: user)

    log_in user
    visit dashboard_path

    click_link "dashboard-edit-resume"

    click_link "Add a video"

    fill_in "video_video_url", with: "http://www.youtube.com/watch?v=2kn8im8XOwM"

    expect {
      click_button "Save Video"
    }.to change {
      user.videos.count
    }.from(0).to(1)

    expect(page).to have_content("Delete")
  end

  it "allow deleting videos" do
    user = create(:user)
    create(:resume, user: user)
    create(:video, user: user)

    log_in user
    visit dashboard_path

    click_link "dashboard-edit-resume"

    click_link "Delete"

    expect(page).to_not have_content("http://www.youtube.com/watch?v=m8u8Z3bUQfs")
  end

  it "allows adding project" do
    user = create(:user)
    create(:resume, user: user)
    create(:project_type, name: "Film Project")

    log_in user
    visit dashboard_path

    click_link "dashboard-edit-resume"

    click_link "Add a project"

    expect(page).to have_content("Director/Studio")

    select "Film Project", from: "Project Type"
    fill_in "Title", with: "Once Upon A Time"
    fill_in "Role", with: "Cinderella"
    fill_in "Director/Studio", with: "Disney Studios"

    click_button "Save Project"

    expect(page).to have_content("Film Project")
    expect(page).to have_content("Once Upon A Time")
    expect(page).to have_content("Cinderella")
    expect(page).to have_content("Disney Studios")
  end

  it "allows editing a project" do
    user = create(:user)
    create(:resume, user: user)
    create(:project, title: "Over You", user: user)
    create(:project_type, name: "Industrial Project")

    log_in user
    visit dashboard_path

    click_link "dashboard-edit-resume"
    click_link "Edit"

    select "Industrial Project", from: "Project Type"
    fill_in "Title", with: "Industrial"
    fill_in "Role", with: "Gopher"
    fill_in "Director/Studio", with: "Tin Cup"

    click_button "Save"

    expect(page).to have_content("Industrial Project")
    expect(page).to have_content("Industrial")
    expect(page).to have_content("Gopher")
    expect(page).to have_content("Tin Cup")
  end

  it "allows adding a school" do
    user = create(:user)
    create(:resume, user: user)

    log_in user
    visit dashboard_path

    click_link "dashboard-edit-resume"

    click_link "Add a school"
    select "College", from: "Education Type"
    fill_in "School", with: "Michigan Tech"
    fill_in "Major", with: "Computer Science"
    fill_in "Degree", with: "Masters"

    click_button "Save school"

    expect(page).to have_content("College")
    expect(page).to have_content("Michigan Tech")
    expect(page).to have_content("Computer Science")
    expect(page).to have_content("Masters")
  end

  it "allows editing a school" do
    user = create(:user)
    create(:resume, user: user)
    create(:school, user: user)

    log_in user
    visit dashboard_path

    click_link "dashboard-edit-resume"

    click_link "Edit"

    select "College", from: "Education Type"
    fill_in "School", with: "Michigan Tech"
    fill_in "Major", with: "Computer Science"
    fill_in "Degree", with: "Masters"

    click_button "Save"

    expect(page).to have_content("College")
    expect(page).to have_content("Michigan Tech")
    expect(page).to have_content("Computer Science")
    expect(page).to have_content("Masters")
  end
end
