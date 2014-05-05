require "spec_helper"

feature "an admin can manage events", js: true do
  let(:admin) { create(:user, :admin) }
  let(:current_date) { Date.current }

  before do
    log_in admin
  end

  scenario "adding an event" do
    create(:region, name: "Central")
    create(:project_type, name: "Episodic")
    create(:union, name: "Extraverts United")

    visit page_path("calendar")
    click_link "Calendar"

    click_link "Add Event"
    visit new_admin_event_path

    current_month = current_date.strftime("%B")
    audition_date = "#{current_month} #{current_date.day}"

    fill_in "Name of Project", with: "Extravaganza!"
    select "Episodic", from: "Project Type"
    select "Central", from: "Region"
    fill_in "Type of Performer Needed", with: "Generally happy people"
    fill_in "Character in Event", with: "Floating ghost"
    fill_in "Wage", with: "1000 Dogecoin/hour"
    check "Extraverts United"
    fill_in "Director", with: "Karl McSweeney"
    fill_in "Story", with: "Happy people become ghosts, have good times"
    fill_in "Description", with: "We need you to have telekentic powers and be willing to yoyo upside down"
    fill_in "Audition Details", with: "In person, there will be a gorilla"
    fill_in "Casting Director", with: "Nic Lindstrom"
    fill_in "Location", with: "Detroit"
    fill_in "Writers", with: "Gordy Howe"
    fill_in "Producers", with: "Wayne Gretzky"

    select current_date.day.to_s, from: "event_audition_date_3i"
    select current_month, from: "event_audition_date_2i"
    select current_date.year, from: "event_audition_date_1i"

    select "1", from: "event_start_date_3i"
    select "December", from: "event_start_date_2i"
    select "2014", from: "event_start_date_1i"

    select "15", from: "event_end_date_3i"
    select "December", from: "event_end_date_2i"
    select "2014", from: "event_end_date_1i"

    check "Paid"

    click_button "Create Event"

    expect(page).to have_content("Calendar")

    datepicker = Dom::CalendarDatepicker.first
    expect(datepicker.month).to eq(current_month)

    event = Dom::CalendarEvent.first

    expect(event.name).to eq("Extravaganza!")
    expect(event.audition_date).to eq(audition_date)
    expect(event.paid?).to be_true
    expect(event.project_type).to eq("Episodic")
    expect(event.region).to eq("Central")
    expect(event.performer_type).to eq("Generally happy people")
    expect(event.character).to eq("Floating ghost")
    expect(event.pay).to eq("1000 Dogecoin/hour")
    expect(event.unions).to eq("Extraverts United")
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
    create(:event, name: "Boring Times", audition_date: Date.current)

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
     create(:event, audition_date: Date.current)

    visit page_path("calendar")
    click_link "Calendar"

    event = Dom::CalendarEvent.first
    event.click_delete

    expect(Dom::CalendarEvent.all.count).to eq(0)
  end
end
