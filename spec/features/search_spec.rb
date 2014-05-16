require "spec_helper"

describe "searching resumes", js: true do
  before do
    johnny = create(:user, name: "Johnny Five")
    johnny.resume.update_attributes({
      descriptive_tag: "I'm a robot!"
    })

    create(:user, name: "Chris Five")
  end

  it "searches users and returns results" do
    visit root_path

    fill_in "Search", with: "Five"
    page.execute_script("document.getElementById('search-form').submit();")
    expect(page).to have_content "Your search for \"Five\" returned 2 results"

    results = Dom::SearchResult.all
    expect(results.count).to eq(2)

    fill_in "Search", with: "Johnny"
    page.execute_script("document.getElementById('search-form').submit();")
    expect(page).to have_content "Your search for \"Johnny\" returned 1 result"

    results = Dom::SearchResult.all
    expect(results.count).to eq(1)
    expect(results.first.name).to eq("Johnny Five")
    expect(results.first.descriptive_tag).to eq("I'm a robot!")
  end
end
