require "spec_helper"

describe "manage resume" do
  it 'allows talent to create a resume' do
    user = create(:user)

    log_in user
    visit dashboard_path

    click_link('Edit Personal Information')

    fill_in "Phone", with: "1-616-123-4567"
    select "6'3", from: "resume_height"
    fill_in "Weight", with: "140"
    select "Blond", from: "resume_hair_color"
    select "Blue", from: "resume_eye_color"
    check "Screen Actors Guild"
    fill_in "Agent name", with: "Awesome Agent"
    fill_in "Agent phone", with: "1-616-456-7890"
    fill_in "Additional skills", with: "Many years of improve from Disney Stages."
    fill_in "Descriptive Tag", with: "Actor, Dancer, and just plain fabulous!"

    click_button "Save"

    expect(page).to have_content("Test Dummy")
    expect(page).to have_content("Actor, Dancer, and just plain fabulous!")
    expect(page).to have_content("1-616-123-4567")
    expect(page).to have_content("140")
    expect(page).to have_content("blond")
    expect(page).to have_content("blue")
    expect(page).to have_content("Screen Actors Guild")
    expect(page).to have_content("Awesome Agent")
    expect(page).to have_content("1-616-456-7890")

  end

  it 'allows talent to edit a resume' do
    user = create(:user, name: "New Name")
    create(:resume, user: user)

    log_in user
    visit dashboard_path

    click_link('Edit Personal Information')

    expect(find_field("Phone").value).to eq("1-616-555-4567")
    expect(find_field("resume_height").value).to eq("69")
    expect(find_field("Weight").value).to eq("140")
    expect(find_field("resume_hair_color").value).to eq("blond")
    expect(find_field("resume_eye_color").value).to eq("blue")
    expect(find_field("resume_agent_name").value).to eq("Awesome Agent")
    expect(find_field("resume_agent_phone").value).to eq("1-616-667-8989")
    expect(find_field("resume_descriptive_tag").value).to eq("Dancer, Actor")

    select "5'10", from: "resume_height"
    fill_in "Weight", with: "155"
    select "Brown", from: "resume_hair_color"
    select "Green", from: "resume_eye_color"
    fill_in "Descriptive Tag", with: "Singer"


    click_button "Save"

    expect(page).to have_content("70")
    expect(page).to have_content(155)
    expect(page).to have_content("brown")
    expect(page).to have_content("green")
    expect(page).to have_content("Singer")
  end

  it "displays validation errors for required resume information" do
    user = create(:user)

    log_in user
    visit dashboard_path

    click_link('Edit Personal Information')


    fill_in "Phone", with: ""

    click_button "Save"

    expect(page).to have_content("Phone can't be blank")
  end

  it "allows adding project" do
    user = create(:user)
    create(:resume, user: user)

    log_in user
    visit dashboard_path

    click_link "Edit Personal Information"

    click_link "Add Project"

    select "Film Project", from: "Project Type"
    fill_in "Title", with: "Once Upon A Time"
    fill_in "Role", with: "Cinderella"
    fill_in "Director/Studio", with: "Disney Studios"

    click_button "Save"

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

    click_link "Edit Personal Information"
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

    click_link "Edit Personal Information"

    click_link "Add School"
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

  it "allows editing a school" do
    user = create(:user)
    create(:resume, user: user)
    create(:school, user: user)

    log_in user
    visit dashboard_path

    click_link "Edit Personal Information"

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
