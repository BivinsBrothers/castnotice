require "spec_helper"

feature "calendar", js: true do
  context "as a member" do
    before do
      user = create(:user)
      log_in user
    end

    it "displays full event information" do
      create(:event, :paid,
        name: "Extravaganza!",
        audition_date: Date.parse("2014-04-18"),
        region: "Canada",
        performer_type: "Clowns",
        project_type: "PSA",
        character: "Floating ghost",
        pay: "$40/hour",
        union: "Extraverts United",
        director: "Karl McSweeney",
        story: "Happy people become ghosts, have good times",
        description: "Chris is getting google glass",
        audition: "Wears glasses",
        start_date: Date.parse("2014-06-01"),
        end_date: Date.parse("2014-06-15")
      )

      visit page_path("calendar")

      event = Dom::CalendarEvent.first

      expect(event.name).to eq("Extravaganza!")
      expect(event.audition_date).to eq("April 18")
      expect(event.paid?).to be_true
      expect(event.region).to eq("Canada")
      expect(event.performer_type).to eq("Clowns")
      expect(event.project_type).to eq("PSA")
      expect(event.character).to eq("Floating ghost")
      expect(event.pay).to eq("$40/hour")
      expect(event.union).to eq("Extraverts United")
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
        audition_date: Date.parse("2014-04-18"),
        region: "Canada",
        performer_type: "Clowns",
        project_type: "PSA"
      )

      visit page_path("calendar")

      event = Dom::CalendarEvent.first

      expect(event.name).to eq("Extravaganza!")
      expect(event.audition_date).to eq("April 18")
      expect(event.paid?).to be_true
      expect(event.region).to eq("Canada")
      expect(event.performer_type).to eq("Clowns")
      expect(event.project_type).to eq("PSA")

      event.toggle_more_information

      expect(event.more_information).to eq("To find out detailed information about this event, you must be logged into CastNotice. Please Sign in or Register")
    end
  end

  it "filters by month in sidebar" do
    Timecop.travel("2014-04-15")

    create(:event, audition_date: Date.parse("2014-04-10"))
    create(:event, audition_date: Date.parse("2014-05-18"))
    create(:event, audition_date: Date.parse("2014-05-19"))

    visit page_path("calendar")
    expect(Dom::CalendarEvent.all.count).to eq(1)

    april_event = Dom::CalendarEvent.first
    expect(april_event.audition_date).to eq("April 10")

    find(".ui-datepicker-next").click
    expect(Dom::CalendarEvent.all.count).to eq(2)

    may_event1 = Dom::CalendarEvent.first
    may_event2 = Dom::CalendarEvent.all.last

    expect(may_event1.audition_date).to eq("May 18")
    expect(may_event2.audition_date).to eq("May 19")

    Timecop.return
  end
end
