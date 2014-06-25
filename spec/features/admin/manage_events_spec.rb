require "spec_helper"

feature "an admin or mentor can manage events", js: true do
  let(:current_date) { Date.current }

  before do
    enter_promo_code
  end

  scenario "allows only mentors and admins to create events" do
    user   = create(:user)
    mentor = create(:user, :mentor)
    admin  = create(:user, :admin)

    log_in user
    visit page_path("calendar")
    expect(page).not_to have_content("Add Event")
    click_link "sign out"

    log_in mentor
    visit page_path("calendar")
    click_link "Add Event"
    expect(page).to have_content("Create an event")
    click_link "sign out"

    log_in admin
    visit page_path("calendar")
    click_link "Add Event"
    expect(page).to have_content("Create an event")
  end

  context "as an admin" do
    let(:admin) { create(:user, :admin) }

    before do
      log_in admin
    end

    scenario "adding an event" do
      create(:region, name: "Central")
      create(:project_type, name: "Episodic")
      create(:union, name: "Extraverts United")

      visit page_path("calendar")
      click_link "Add Event"

      current_month = current_date.strftime("%B")
      audition_date = "#{current_month} #{current_date.day}"

      fill_in "Name of Project", with: "Extravaganza!"
      select "Episodic", from: "Project Type"
      select "Central", from: "Region"
      check "Extraverts United"
      fill_in "Story", with: "Happy people become ghosts, have good times"
      fill_in "Description", with: "We need you to have telekentic powers and be willing to yoyo upside down"
      fill_in "Audition Details", with: "In person, there will be a gorilla"
      fill_in "Casting Director", with: "Nic Lindstrom"
      fill_in "Audition Location", with: "Detroit"
      fill_in "Production Location", with: "Los Angeles"
      fill_in "Special Notes", with: "Lawn care"
      fill_in "Pay Rate", with: "$500-$1,000"
      fill_in "Staff", with: "Assistant to the coffee-getter"

      select current_date.day.to_s, from: "event_audition_date_3i"
      select current_month, from: "event_audition_date_2i"
      select current_date.year, from: "event_audition_date_1i"

      check "Paid"

      find("#create-event").trigger("click")

      expect(page).to have_content("Calendar")

      datepicker = Dom::CalendarDatepicker.first
      expect(datepicker.month).to eq(current_month)

      event = Dom::CalendarEvent.first

      expect(event.project_title).to eq("Extravaganza!")
      expect(event.audition_date).to eq(audition_date)
      expect(event.paid?).to be_true
      expect(event.project_type).to eq("Episodic")
      expect(event.region).to eq("Central")
      expect(event.unions).to eq("Extraverts United")
      expect(event.casting_director).to eq("Nic Lindstrom")
      expect(event.location).to eq("Detroit")

      event.toggle_more_information
      expect(event.storyline).to eq("Happy people become ghosts, have good times")
      expect(event.character_description).to eq("We need you to have telekentic powers and be willing to yoyo upside down")
      expect(event.how_to_audition).to eq("In person, there will be a gorilla")
      expect(event.special_notes).to eq("Lawn care")
    end

    scenario "editing an event" do
      create(:event, :full, project_title: "Boring Times", audition_date: Date.current)

      visit page_path("calendar")
      click_link "Calendar"

      event = Dom::CalendarEvent.first

      expect(event.project_title).to eq("Boring Times")

      event.click_edit

      fill_in "Name of Project", with: "Extravaganza!"
      find("#update-event").trigger("click")

      expect(page).to have_content("Extravaganza!")

      updated_event = Dom::CalendarEvent.first
      expect(updated_event.project_title).to eq("Extravaganza!")
    end

    scenario "deleting an event" do
      create(:event, :full, audition_date: Date.current)

      visit page_path("calendar")
      click_link "Calendar"

      event = Dom::CalendarEvent.first
      event.click_delete

      expect(Dom::CalendarEvent.all.count).to eq(0)
    end

    scenario "listing rolls for an event" do
      event = create(:event, :full, audition_date: 1.day.from_now)
      other_event = create(:event, :full, audition_date: 3.day.from_now)

      create(:roll, event: event)
      create(:roll, event: event)
      create(:roll, event: other_event)

      visit page_path("calendar")
      click_link "Calendar"

      Dom::CalendarEvent.first.manage_rolls

      rolls = Dom::CalendarEventRoll.all

      expect(rolls.size).to eq(2)
    end

    scenario "adding a roll to an event" do
      create(:event, :full, audition_date: 1.day.from_now)

      visit page_path("calendar")
      click_link "Calendar"

      Dom::CalendarEvent.first.manage_rolls

      click_link "Add Roll"

      fill_in "Description", with: "Lead character, Dorthy"
      fill_in "Gender", with: "female"
      fill_in "Ethnicity", with: "white"
      select "21", from: "Age Min"
      select "32", from: "Age Max"
      click_button "Create Roll"

      rolls = Dom::CalendarEventRoll.all

      expect(rolls.size).to eq(1)
    end
  end

end
