require "spec_helper"

describe Resume do
  describe "#public_url" do
    before do
      env = double(:env, castnotice_domain: "fake.location")
      Figaro.stub(env: env)
    end

    it "uses friendly id as slug by default" do
      resume = create(:resume)

      expect(resume.public_url).to eq("http://fake.location/r/#{resume.friendly_id}")
    end

    it "uses slug when one is set" do
      resume = create(:resume, slug: "backpack")

      expect(resume.public_url).to eq("http://fake.location/r/backpack")
    end
  end
end
