require "spec_helper"

describe "public resume view" do
  it "displays public resume attributes" do
    resume = create(:resume, descriptive_tag: "Watch out!")

    visit public_resume_path(resume.friendly_id)

    expect(page).to have_content("Watch out!")
  end

  it "displays parental information when talent is under 18" do
    user = create(:user, :with_parent, birthday: 17.years.from_now, parent_name: "Bam Mam")
    resume = create(:resume, user: user)

    visit public_resume_path(resume.friendly_id)

    expect(page).to have_content("Parental Information")
    expect(page).to have_content("Bam Mam")
  end
end
