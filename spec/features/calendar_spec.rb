require "spec_helper"

feature "calendar", js: true do
  let(:this_month) { Date.current }
  let(:region) { create(:region, name: "Canada") }
  let(:project_type) { create(:project_type, name: "PSA") }
  let(:union1) { create(:union, name: "Extraverts United") }
  let(:union2) { create(:union, name: "UEA") }

  context "as a member" do
    before do
      user = create(:user)
      log_in user
    end

    it "displays full event information" do
      create(:event, :paid,
        project_title: "Extravaganza!",
        audition_date: this_month,
        region: region,
        project_type: project_type,
        unions: [union1, union2],
        casting_director: "Karl McSweeney",
        gender: "Male",
        storyline: "Happy people become ghosts, have good times",
        character_description: "Chris is getting google glass",
        how_to_audition: "Wears glasses",
        special_notes: "It involves a washer",
        additional_project_info: "Donations accepted",
        project_type_details: "Elephants",
        start_date: "2014-06-01"
      )

      visit page_path("calendar")

      event = Dom::CalendarEvent.first

      expect(event.project_title).to eq("Extravaganza!")
      expect(event.audition_date).to eq(this_month.strftime('%B %-d'))
      expect(event.paid?).to be_true
      expect(event.region).to eq("Canada")
      expect(event.project_type).to eq("PSA")
      expect(event.unions).to eq("Extraverts United, UEA")
      expect(event.gender).to eq("Male")
      expect(event.casting_director).to eq("Karl McSweeney")
      expect(event.start_date).to eq("06-01-14")

      event.toggle_more_information

      expect(event.storyline).to eq("Happy people become ghosts, have good times")
      expect(event.character_description).to eq("Chris is getting google glass")
      expect(event.how_to_audition).to eq("Wears glasses")
      expect(event.special_notes).to eq("It involves a washer")
      expect(event.additional_project_info).to eq("Donations accepted")
      expect(event.project_type_details).to eq("Elephants")
    end
  end

  context "as a visitor" do
    it "displays limited event information" do
      create(:event, :paid,
        project_title: "Extravaganza!",
        audition_date: this_month,
        region: region,
        project_type: project_type
      )

      visit page_path("calendar")

      event = Dom::CalendarEvent.first

      expect(event.project_title).to eq("Extravaganza!")
      expect(event.audition_date).to eq(this_month.strftime('%B %-d'))
      expect(event.paid?).to be_true
      expect(event.region).to eq("Canada")
      expect(event.project_type).to eq("PSA")

      event.toggle_more_information

      expect(event.more_information).to eq("To find out detailed information about this event, you must be logged into CastNotice. Please Sign in or Register")
    end
  end

  it "displays filtering categories" do
    create(:region, name: "New Zealand")
    create(:project_type, name: "Lorde cover")
    create(:union, name: "Crystal")

    visit page_path("calendar")

    region  = Dom::CalendarRegion.first
    project = Dom::CalendarProjectType.first
    union   = Dom::CalendarUnion.first

    expect(region.name).to eq("New Zealand")
    expect(project.name).to eq("Lorde cover")
    expect(union.name).to eq("Crystal")
  end

  it "filters by month in sidebar" do
    next_month = this_month.next_month

    create(:event, audition_date: this_month, paid: false)
    create(:event, audition_date: next_month, paid: true)

    visit page_path("calendar")

    first_event = Dom::CalendarEvent.first
    expect(first_event.audition_date).to eq(this_month.strftime('%B %-d'))

    datepicker = Dom::CalendarDatepicker.first

    expect(datepicker.month).to eq(this_month.strftime("%B"))
    datepicker.next_month
    expect(datepicker.month).to eq(next_month.strftime("%B"))

    find(".calendar-paid-true")

    next_event = Dom::CalendarEvent.first
    expect(next_event.audition_date).to eq(next_month.strftime('%B %-d'))
  end

  it "filters by selected categories" do
    oxford    = create(:event, region: create(:region, name: "Oxford"))
    cambridge = create(:event, project_title: "Beatles Reunion", region: create(:region, name: "Cambridge"))

    visit page_path("calendar")

    events = Dom::CalendarEvent.all
    expect(events.count).to eq(2)

    Dom::CalendarRegion.select_region_id(oxford.id)

    expect(page).not_to have_content("Beatles Reunion")

    events = Dom::CalendarEvent.all
    expect(events.count).to eq(1)
    expect(Dom::CalendarEvent.first.region).to eq("Oxford")
  end
end
