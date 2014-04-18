require "spec_helper"

def event_hash(event)
  {
     id: event.id,
     name: event.name,
     project_type: event.project_type,
     region: event.region,
     performer_type: event.performer_type,
     character: event.character,
     pay: event.pay,
     union: event.union,
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
     producers: event.producers
  }
end

def limited_event_hash(event)
  {
     name: event.name,
     project_type: event.project_type,
     region: event.region,
     performer_type: event.performer_type,
     audition_date: event.audition_date.strftime("%Y-%m-%d"),
     paid: event.paid
  }
end

describe "Calendar API" do
  describe "GET /events" do
    it "returns full event json ordered by audition date when a member" do
      user = create(:user)
      login_as user

      event2 = create(:event, created_at: 1.day.ago, audition_date: 2.days.from_now)
      event1 = create(:event, created_at: 2.days.ago, audition_date: 1.day.from_now)

      get events_path

      expect(response.status).to eq(200)
      expect(response.body).to eq({
        "events" => [event_hash(event1), event_hash(event2)],
        "meta" => {member: true, admin: false}
      }.to_json)
    end

    it "returns a maximum of a 20 events" do
      create_list(:event, 21)

      get events_path

      expect(response.status).to eq(200)
      response_json = JSON.parse(response.body)
      expect(response_json["events"].count).to eq(20)
    end

    it "returns limited json when not a member" do
      event = create(:event)

      get events_path

      expect(response.status).to eq(200)
      expect(response.body).to eq({
        "events" => [limited_event_hash(event)],
        "meta" => {member: false, admin: false}
      }.to_json)
    end
  end
end