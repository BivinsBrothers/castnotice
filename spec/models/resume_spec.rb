require "spec_helper"

describe Resume do
  let!(:user) { create(:user, name: "iggy") }

  it "triggers friendly_id slug auto build if slug is empty string" do
    resume = build(:resume, user: user, slug: "")

    expect(resume.save).to be_true
    expect(resume.slug).to eq("iggy")
  end

  it "saves custom slug if given a value" do
    resume = build(:resume, user: user, slug: "flow")

    expect(resume.save).to be_true
    expect(resume.slug).to eq("flow")
  end

  it "paramertizes the slug if given something non-URL friendly" do
    resume = build(:resume, user: user, slug: "flow & control")

    expect(resume.save).to be_true
    expect(resume.slug).to eq("flow-control")
  end
end
