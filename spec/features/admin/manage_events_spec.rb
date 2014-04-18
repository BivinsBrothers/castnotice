require "spec_helper"

feature "an admin can manage events", js: true do
  let(:admin) { create(:user, :admin) }

  before do
    log_in admin
  end

  scenario "adding an event" do
    visit page_path("calendar")
    click_link "Calendar"

    click_link "Add Event"
    visit new_admin_event_path

    fill_in "Name of Project", with: "Extravaganza!"
    fill_in "Project Type", with: "Poodle show"
    fill_in "Region", with: "Middle West"
    fill_in "Type of Performer Needed", with: "Generally happy people"
    fill_in "Character in Event", with: "Floating ghost"
    fill_in "Wage", with: "1000 Dogecoin/hour"
    fill_in "Union", with: "Extraverts United"
    fill_in "Director", with: "Karl McSweeney"
    fill_in "Story", with: "Happy people become ghosts, have good times"
    fill_in "Description", with: "We need you to have telekentic powers and be willing to yoyo upside down"
    fill_in "Audition Details", with: "In person, there will be a gorilla"
    fill_in "Casting Director", with: "Nic Lindstrom"
    fill_in "Location", with: "Detroit"
    fill_in "Writers", with: "Gordy Howe"
    fill_in "Producers", with: "Wayne Gretzky"

    select "1", from: "event_audition_date_3i"
    select "September", from: "event_audition_date_2i"
    select "2014", from: "event_audition_date_1i"

    select "1", from: "event_start_date_3i"
    select "December", from: "event_start_date_2i"
    select "2014", from: "event_start_date_1i"

    select "15", from: "event_end_date_3i"
    select "December", from: "event_end_date_2i"
    select "2014", from: "event_end_date_1i"

    check "Paid"

    click_button "Create Event"

    expect(page).to have_content("Calendar")

    event = Dom::CalendarEvent.first

    expect(event.name).to eq("Extravaganza!")
    expect(event.audition_date).to eq("September 1")
    expect(event.paid?).to be_true
    expect(event.project_type).to eq("Poodle show")
    expect(event.region).to eq("Middle West")
    expect(event.performer_type).to eq("Generally happy people")
    expect(event.character).to eq("Floating ghost")
    expect(event.pay).to eq("1000 Dogecoin/hour")
    expect(event.union).to eq("Extraverts United")
    expect(event.director).to eq("Karl McSweeney")
    expect(event.casting_director).to eq("Nic Lindstrom")
    expect(event.writers).to eq("Gordy Howe")
    expect(event.producers).to eq("Wayne Gretzky")
    expect(event.location).to eq("Detroit")

    expect(event.start_date).to eq("12-01-14")
    expect(event.end_date).to eq("12-15-14")

    event.toggle_more_information

    expect(event.story).to eq("Happy people become ghosts, have good times")
    expect(event.description).to eq("We need you to have telekentic powers and be willing to yoyo upside down")
    expect(event.audition).to eq("In person, there will be a gorilla")
  end

  scenario "editing an event" do
    create(:event, name: "Boring Times")

    visit page_path("calendar")
    click_link "Calendar"

    event = Dom::CalendarEvent.first

    expect(event.name).to eq("Boring Times")

    event.click_edit

    fill_in "Name of Project", with: "Extravaganza!"
    click_button "Update Event"

    updated_event = Dom::CalendarEvent.first
    expect(updated_event.name).to eq("Extravaganza!")
  end


  scenario "deleting an event" do
    create(:event)

    visit page_path("calendar")
    click_link "Calendar"

    event = Dom::CalendarEvent.first
    event.click_delete

    expect(Dom::CalendarEvent.all.count).to eq(0)
  end
end