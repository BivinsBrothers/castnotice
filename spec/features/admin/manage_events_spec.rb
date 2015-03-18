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

    scenario "validations" do
      within("header") do
        click_link "Calendar"
      end
      click_link "Add Event"
      click_button "Create Event"

      expect(page).to have_content("Project title can't be blank")
      expect(page).to have_content("Unions can't be blank")
      expect(page).to have_content("Production location can't be blank")
      expect(page).to have_content("Pay rate can't be blank")
      expect(page).to have_content("Staff can't be blank")
      expect(page).to have_content("Location can't be blank")
      expect(page).to have_content("How to audition can't be blank")
    end

    scenario "adding an event" do
      create(:region, name: "Central")
      create(:project_type, name: "Episodic")

      visit page_path("calendar")
      click_link "Add Event"

      current_month = current_date.strftime("%B")
      audition_date = "#{current_month} #{current_date.day}"

      fill_in "Name of Project", with: "Extravaganza!"
      select "Episodic", from: "Project Type"
      select "Central", from: "Region"
      check "Awesome Union"
      fill_in "Story", with: "Happy people become ghosts, have good times"
      fill_in "Audition Details", with: "In person, there will be a gorilla"
      fill_in "Casting Director", with: "Nic Lindstrom"
      fill_in "Audition Location", with: "Detroit"
      fill_in "Production Location", with: "Los Angeles"
      fill_in "Special Notes", with: "Lawn care"
      fill_in "Pay Rate", with: "$500-$1,000"
      fill_in "Staff", with: "Assistant to the coffee-getter"

      select current_date.day.to_s, from: "event_event_audition_dates_attributes_0_audition_date_3i"
      select current_month, from: "event_event_audition_dates_attributes_0_audition_date_2i"
      select current_date.year, from: "event_event_audition_dates_attributes_0_audition_date_1i"

      check "Paid"
      check "Stipend"

      find("#create-event").click

      expect(page).to have_content("Calendar")

      datepicker = Dom::CalendarDatepicker.first
      expect(datepicker.month).to eq(current_month)

      event = Dom::CalendarEvent.first

      expect(event.project_title).to eq("Extravaganza!")
      expect(event.audition_date).to eq(audition_date)
      expect(event).to be_paid
      expect(event).to be_stipend
      expect(event.project_type).to eq("Episodic")
      expect(event.region).to eq("Central")
      expect(event.unions).to eq("Awesome Union")
      expect(event.casting_director).to eq("Nic Lindstrom")
      expect(event.location).to eq("Detroit")

      event.toggle_more_information
      expect(event.storyline).to eq("Happy people become ghosts, have good times")
      expect(event.how_to_audition).to eq("In person, there will be a gorilla")
      expect(event.special_notes).to eq("Lawn care")
    end

    scenario "editing an event" do
      create(:event, :full, project_title: "Boring Times", audition_date: Date.current)

      visit page_path("calendar")
      click_link "Calendar"
      uncheck "Awesome Union"
      wait_for_ajax

      event = Dom::CalendarEvent.first

      expect(event.project_title).to eq("Boring Times")

      event.click_edit

      fill_in "Name of Project", with: "Extravaganza!"
      find("#update-event").click

      uncheck "Awesome Union"
      wait_for_ajax

      expect(page).to have_content("Extravaganza!")

      updated_event = Dom::CalendarEvent.first
      expect(updated_event.project_title).to eq("Extravaganza!")
    end

    scenario "deleting an event" do
      create(:event, :full, audition_date: Date.current)

      visit page_path("calendar")
      click_link "Calendar"
      uncheck "Awesome Union"
      wait_for_ajax

      event = Dom::CalendarEvent.first
      event.click_delete

      expect(Dom::CalendarEvent.all.count).to eq(0)
    end

    scenario "listing roles for an event" do
      event_date = Time.now
      event = create(:event, :full, audition_date: event_date)

      create(:role, event: event)
      create(:role, event: event)

      visit page_path("calendar")
      click_link "Calendar"
      uncheck "Awesome Union"
      wait_for_ajax

      Dom::CalendarEvent.first.manage_roles

      roles = Dom::CalendarEventRole.all

      expect(roles.size).to eq(2)
    end

    scenario "adding a role to an event" do
      create(:event, :full, audition_date: Date.today)

      visit page_path("calendar")
      click_link "Calendar"
      uncheck "Awesome Union"
      wait_for_ajax

      Dom::CalendarEvent.first.manage_roles

      click_link "Add Role"

      fill_in "Seeking", with: "Lead character, Dorthy"
      fill_in "Gender", with: "female"
      fill_in "Ethnicity", with: "white"
      select "21", from: "Age Min"
      select "32", from: "Age Max"
      click_button "Create Role"

      roles = Dom::CalendarEventRole.all

      expect(roles.size).to eq(1)
    end

    scenario "editing an existing event" do
      create(:event, :full, audition_date: 1.day.from_now)
      create(:role, description: "Dorthy")


      visit page_path("calendar")
      click_link "Calendar"
      uncheck "Awesome Union"
      wait_for_ajax
      Dom::CalendarEvent.first.manage_roles

      Dom::CalendarEventRole.first.edit

      fill_in "Seeking", with: "Lead character, Dorthy"
      click_button "Update Role"

      role = Dom::CalendarEventRole.first

      expect(role.description).to eq("Lead character, Dorthy")
    end

    scenario "removing an  role from an event" do
      event = create(:event, :full, audition_date: 1.day.from_now)
      create(:role, description: "Dorthy")

      visit page_path("calendar")
      click_link "Calendar"
      uncheck "Awesome Union"
      wait_for_ajax

      Dom::CalendarEvent.first.manage_roles

      Dom::CalendarEventRole.first.delete

      expect(event.roles).to be_empty
    end

    scenario "viewing a role details" do
      create(:event, :full, audition_date: 1.day.from_now)
      create(:role, description: "Dorthy")

      visit page_path("calendar")
      click_link "Calendar"
      uncheck "Awesome Union"
      wait_for_ajax

      Dom::CalendarEvent.first.manage_roles

      Dom::CalendarEventRole.first.view_details

      expect(page).to have_content("Dorthy")
    end
  end

end
