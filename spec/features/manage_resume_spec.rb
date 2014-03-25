require "spec_helper"

describe "manage resume" do
  it 'allows talent to create a resume' do
    user = create(:user)

    log_in user
    visit dashboard_path

    click_link('Create Resume')
    expect(page).to have_content('My Close Up')

    fill_in "Phone", with: "1-616-123-4567"
    select "6'3", from: "resume_height"
    fill_in "Weight", with: "140"
    select "Blond", from: "resume_hair_color"
    select "Blue", from: "resume_eye_color"
    check "Screen Actors Guild"
    fill_in "Agent name", with: "Awesome Agent"
    fill_in "Agent phone", with: "1-616-456-7890"
    fill_in "Additional skills", with: "Many years of improve from Disney Stages."

    click_button "Save My Close Up"

    expect(page).to have_content("Dashboard")
    expect(page).to have_content("1-616-123-4567")
    expect(page).to have_content("140")
    expect(page).to have_content("blond")
    expect(page).to have_content("blue")
    expect(page).to have_content("Screen Actors Guild")
    expect(page).to have_content("Awesome Agent")
    expect(page).to have_content("1-616-456-7890")
    expect(page).to have_content("Many years of improve from Disney Stages.")

    expect(page).to have_link("Edit My Close Up")
  end

  it 'allows talent to edit a resume' do
    user = create(:user, name: "New Name")
    create(:resume, user: user)

    log_in user
    visit dashboard_path

    click_link('Edit My Close Up')
    expect(page).to have_content('Edit My Close Up')

    expect(find_field("Phone").value).to eq("1-616-555-4567")
    expect(find_field("resume_height").value).to eq("69")
    expect(find_field("Weight").value).to eq("140")
    expect(find_field("resume_hair_color").value).to eq("blond")
    expect(find_field("resume_eye_color").value).to eq("blue")
    expect(find_field("resume_agent_name").value).to eq("Awesome Agent")
    expect(find_field("resume_agent_phone").value).to eq("1-616-667-8989")


    select "5'10", from: "resume_height"
    fill_in "Weight", with: "155"
    select "Brown", from: "resume_hair_color"
    select "Green", from: "resume_eye_color"

    click_button "Save My Close Up"

    expect(page).to have_content("70")
    expect(page).to have_content(155)
    expect(page).to have_content("brown")
    expect(page).to have_content("green")
  end

  it "displays validation errors for required resume information" do
    user = create(:user)

    log_in user
    visit dashboard_path

    click_link "Create Resume"

    fill_in "Phone", with: ""

    click_button "Save My Close Up"

    expect(page).to have_content("Phone can't be blank")
  end

  it "allows talent to upload an avatar" do
    user = create(:user)
    resume = create(:resume, user: user)

    log_in user
    visit dashboard_path

    click_link "Upload Hot Shot"
    expect(page).to have_content("Upload Hot Shot")
    click_button "Save My Close Up"

    resume.avatar = File.open(File.join(Rails.root, 'spec', 'fixtures', 'avatar.jpg'))
    resume.save!

    click_link "Upload Hot Shot"
    expect(page).to have_content("Change Hot Shot")
    click_button "Save My Close Up"

    expect(page).to have_content("Your Hot Shot")
  end

  it "displays validation errors for required attributes on a user" do
    user = create(:user)

    log_in user
    visit dashboard_path

    click_link "Edit My User Information"

    fill_in "Name", with: ""
    fill_in "Email", with: ""

    click_button "Update User"

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Name can't be blank")
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

  it "allows adding a school" do
    user = create(:user)
    create(:resume, user: user)

    log_in user
    visit dashboard_path

    click_link "New School"

    select "College", from: "Education Type"
    fill_in "School", with: "Michigan Tech"
    fill_in "Major", with: "Computer Science"
    fill_in "Degree", with: "Masters"

    click_button "Create School"

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

    click_link "Edit School"

    select "College", from: "Education Type"
    fill_in "School", with: "Michigan Tech"
    fill_in "Major", with: "Computer Science"
    fill_in "Degree", with: "Masters"

    click_button "Update School"

    expect(page).to have_content("College")
    expect(page).to have_content("Michigan Tech")
    expect(page).to have_content("Computer Science")
    expect(page).to have_content("Masters")
  end
end
