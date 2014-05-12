require "spec_helper"

def full_event_hash(event)
  {
     id: event.id,
     name: event.name,
     project_type: event.project_type.name,
     region: event.region.name,
     performer_type: event.performer_type,
     character: event.character,
     pay: event.pay,
     director: event.director,
     story: event.story,
     description: event.description,
     audition: event.audition,
     audition_date: event.audition_date.strftime("%Y-%m-%d"),
     start_date: event.start_date.strftime("%m-%d-%y"),
     end_date: event.end_date.strftime("%m-%d-%y"),
     paid: event.paid,
     location: event.location,
     casting_director: event.casting_director,
     writers: event.writers,
     producers: event.producers,
     unions: (event.unions.map {|u| {name: u.name} })
  }
end

def limited_event_hash(event)
  {
     name: event.name,
     project_type: event.project_type.name,
     region: event.region.name,
     performer_type: event.performer_type,
     audition_date: event.audition_date.strftime("%Y-%m-%d"),
     paid: event.paid
  }
end

describe "Calendar API" do
  describe "GET /events" do
    before do
      Timecop.freeze(Date.parse("2014-04-17"))
    end

    after do
      Timecop.return
    end

    context "when a member" do
      before do
        user = create(:user)
        login_as user
      end

      it "returns full event json" do
        event = create(:event, audition_date: 2.days.from_now)

        get events_path

        expect(response.body).to eq({
          "events" => [full_event_hash(event)],
          "meta" => {member: true, admin: false}
        }.to_json)
      end
    end

    context "when not a member" do
      it "returns limited event json" do
        event = create(:event, audition_date: 2.days.from_now)

        get events_path

        expect(response.status).to eq(200)
        expect(response.body).to eq({
          "events" => [limited_event_hash(event)],
          "meta" => {member: false, admin: false}
        }.to_json)
      end
    end

    context "when given a date range" do
      let!(:may_event) { create(:event, audition_date: 1.month.from_now) }
      let!(:april_event1) { create(:event, audition_date: 2.days.from_now) }
      let!(:april_event2) { create(:event, audition_date: 1.day.from_now) }
      let!(:feb_event) { create(:event, audition_date: 2.months.ago) }
      let!(:jan_event) { create(:event, audition_date: 3.months.ago) }

      it "returns events within date range" do
        get events_path, {date: {start: "2014-05-01", end: "2014-05-30" }}

        expect(response.status).to eq(200)
        expect(response.body).to eq({
          "events" => [limited_event_hash(may_event)],
          "meta" => {member: false, admin: false}
        }.to_json)
      end

      it "returns events up to 60 days into the past" do
        get events_path, {date: {start: "2014-02-01", end: "2014-02-28"}}
        expect(response.body).to eq({
          "events" => [limited_event_hash(feb_event)],
          "meta" => {member: false, admin: false}
        }.to_json)

        get events_path, {date: {start: "2014-01-01", end: "2014-01-31"}}
        expect(response.body).to eq({
          "events" => [],
          "meta" => {member: false, admin: false}
        }.to_json)
      end

      context "when not given a date range" do
        it "returns full event json ordered by audition date for the current month" do
          get events_path

          expect(response.status).to eq(200)
          expect(response.body).to eq({
            "events" => [limited_event_hash(april_event2), limited_event_hash(april_event1)],
            "meta" => {member: false, admin: false}
          }.to_json)
        end
      end
    end
  end

  describe "GET /categories" do
    it "returns list of calendar categories that can be filtered" do
      create(:region, name: "Ile-de-France")
      create(:region, name: "Dordogne")

      create(:project_type, name: "Coworking")
      create(:project_type, name: "Dance")

      create(:union, name: "UEA")
      create(:union, name: "IPSA")

  describe "GET /categories" do
    let!(:ile) { create(:region, name: "Ile-de-France") }
    let!(:dordogne) { create(:region, name: "Dordogne") }
    let!(:coworking) { create(:project_type, name: "Coworking") }
    let!(:dance) { create(:project_type, name: "Dance") }
    let!(:uea) { create(:union, name: "UEA") }
    let!(:ipsa) { create(:union, name: "IPSA") }

    it "returns list of calendar categories that can be filtered" do
      get categories_path

      filters = JSON.parse(response.body)["filters"]

      expect(filters["region"]["label"]).to eq("Region")
      expect(filters["region"]["values"]).to eq({
        ile.id.to_s =>"Ile-de-France",
        dordogne.id.to_s => "Dordogne"
      })

      expect(filters["project"]["label"]).to eq("Type of Project")
      expect(filters["project"]["values"]).to eq({
        coworking.id.to_s => "Coworking",
        dance.id.to_s => "Dance"
      })

      expect(filters["union"]["label"]).to eq("Union")
      expect(filters["union"]["values"]).to eq({
        uea.id.to_s => "UEA",
        ipsa.id.to_s => "IPSA"
      })
    end
  end
end
