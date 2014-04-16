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
end
