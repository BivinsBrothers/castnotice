require "spec_helper"

def full_event_hash(event)
  {
     id: event.id,
     project_title: event.project_title,
     project_type: event.project_type.name,
     region: event.region.name,
     storyline: event.storyline,
     character_description: event.character_description,
     how_to_audition: event.how_to_audition,
     audition_date: event.audition_date.strftime("%Y-%m-%d"),
     start_date: event.start_date.strftime("%m-%d-%y"),
     paid: event.paid,
     location: event.location,
     casting_director: event.casting_director,
     gender: event.gender,
     project_type_details: event.project_type_details,
     special_notes: event.special_notes,
     additional_project_info: event.additional_project_info,
     unions: (event.unions.map {|u| {name: u.name} })
  }
end

def limited_event_hash(event)
  {
     project_title: event.project_title,
     project_type: event.project_type.name,
     region: event.region.name,
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
        event = create(:event, :full, audition_date: 2.days.from_now)

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

    context "when given filtering attributes" do
      let(:dordogne) { create(:region, name: "Dordogne") }
      let(:ile)      { create(:region, name: "Ile-de-France") }
      let(:lavazza)  { create(:project_type, name: "Lavazza") }
      let(:orange)   { create(:project_type, name: "Oranage Juice") }
      let(:sncf)     { create(:union, name: "SNCF") }
      let(:ratp)     { create(:union, name: "RATP") }

      let!(:event1) { create(:event, audition_date: Date.today, project_type: orange, region: dordogne, unions: [ratp]) }
      let!(:event2) { create(:event, audition_date: 1.day.from_now, project_type: lavazza, region: ile) }
      let!(:event3) { create(:event, audition_date: 2.days.from_now, project_type: orange, unions: [sncf]) }
      let!(:event4) { create(:event, audition_date: 3.days.from_now, unions: [sncf, ratp]) }

      it "returns events filtered by region" do
        get events_path, {filters: {region: [dordogne.id]}}

        expect(response.body).to eq({
          "events" => [limited_event_hash(event1)],
          "meta" => {member: false, admin: false}
        }.to_json)
      end

      it "returns events filtered by project" do
        get events_path, {filters: {project: [lavazza.id]}}

        expect(response.body).to eq({
          "events" => [limited_event_hash(event2)],
          "meta" => {member: false, admin: false}
        }.to_json)
      end

      it "returns events filtered by multiple values for the same category" do
        get events_path, {filters: {project: [lavazza.id, orange.id]}}

        expect(response.body).to eq({
          "events" => [limited_event_hash(event1), limited_event_hash(event2), limited_event_hash(event3)],
          "meta" => {member: false, admin: false}
        }.to_json)
      end

      it "returns events filtered by union" do
        get events_path, {filters: {union: [sncf.id]}}

        expect(response.body).to eq({
          "events" => [limited_event_hash(event3), limited_event_hash(event4)],
          "meta" => {member: false, admin: false}
        }.to_json)
      end

      it "returns events filtered by different categories" do
        get events_path, {filters: {project: [orange.id], union: [sncf.id, ratp.id]}}

        expect(response.body).to eq({
          "events" => [limited_event_hash(event1), limited_event_hash(event3)],
          "meta" => {member: false, admin: false}
        }.to_json)
      end
    end
  end

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
