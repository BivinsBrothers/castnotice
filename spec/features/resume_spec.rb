require "spec_helper"

feature "public resume view" do
  before do
    enter_promo_code
  end

  scenario "displays public resume attributes" do
    resume = create(:resume, descriptive_tag: "Watch out!")

    visit public_resume_path(resume)

    expect(page).to have_content("Watch out!")
  end

  scenario "displays parental information when talent is under 18" do
    user = create(:user, :with_parent, birthday: 17.years.from_now, parent_name: "Bam Mam")
    resume = create(:resume, user: user)

    visit public_resume_path(resume)

    expect(page).to have_content("Parental Information")
    expect(page).to have_content("Bam Mam")
  end

  scenario "allows user to print resume" do
    resume = create(:resume)
    create(:school, resume: resume)
    create(:project, resume: resume)
    create(:headshot, resume: resume)

    visit public_resume_path(resume.friendly_id)
    click_link "Print Resume"

    expect(page).to have_content("Test Dummy")
    expect(page).to have_content("Awesome Union")
    expect(page).to have_content("1-616-555-4567")
    expect(page).to have_content(resume.user.email)
    expect(page).to have_content("Wizzard of OZ")
    expect(page).to have_content("Dorothy")
    expect(page).to have_content("Disney Studios")
    expect(page).to have_content("Training")
    expect(page).to have_content("Special Skills")
    expect(page).to have_content("Improve")
  end

  scenario "it displays parent info on printable resume when talent is a minor" do
    user = create(:user, birthday: 5.years.ago, parent_name: "Joe Boxer", parent_email: "parent@fake.com",
           parent_phone: "5551231234", parent_location: "Narnia", parent_city: "Elsewhere", parent_state: "Awesome",
           parent_zip: "12345")
    resume = create(:resume, user: user)

    visit public_resume_path(resume.friendly_id)
    click_link "Print Resume"

    expect(page).to have_content("Joe Boxer")
    expect(page).to have_content("5551231234")
  end
end
