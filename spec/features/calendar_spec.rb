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
        name: "Extravaganza!",
        audition_date: this_month,
        region: region,
        performer_type: "Clowns",
        project_type: project_type,
        character: "Floating ghost",
        pay: "$40/hour",
        unions: [union1, union2],
        director: "Karl McSweeney",
        story: "Happy people become ghosts, have good times",
        description: "Chris is getting google glass",
        audition: "Wears glasses",
        start_date: "2014-06-01",
        end_date: "2014-06-15"
      )

      visit page_path("calendar")

      event = Dom::CalendarEvent.first

      expect(event.name).to eq("Extravaganza!")
      expect(event.audition_date).to eq(this_month.strftime('%B %-d'))
      expect(event.paid?).to be_true
      expect(event.region).to eq("Canada")
      expect(event.performer_type).to eq("Clowns")
      expect(event.project_type).to eq("PSA")
      expect(event.character).to eq("Floating ghost")
      expect(event.pay).to eq("$40/hour")
      expect(event.unions).to eq("Extraverts United and UEA")
      expect(event.director).to eq("Karl McSweeney")

      event.toggle_more_information

      expect(event.story).to eq("Happy people become ghosts, have good times")
      expect(event.description).to eq("Chris is getting google glass")
      expect(event.audition).to eq("Wears glasses")
      expect(event.start_date).to eq("06-01-14")
      expect(event.end_date).to eq("06-15-14")
    end
  end

  context "as a visitor" do
    it "displays limited event information" do
      create(:event, :paid,
        name: "Extravaganza!",
        audition_date: this_month,
        region: region,
        performer_type: "Clowns",
        project_type: project_type
      )

      visit page_path("calendar")

      event = Dom::CalendarEvent.first

      expect(event.name).to eq("Extravaganza!")
      expect(event.audition_date).to eq(this_month.strftime('%B %-d'))
      expect(event.paid?).to be_true
      expect(event.region).to eq("Canada")
      expect(event.performer_type).to eq("Clowns")
      expect(event.project_type).to eq("PSA")

      event.toggle_more_information

      expect(event.more_information).to eq("To find out detailed information about this event, you must be logged into CastNotice. Please Sign in or Register")
    end
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
end
