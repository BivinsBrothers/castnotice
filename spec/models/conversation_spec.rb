require "spec_helper"

describe Conversation do
  describe "#other_correspondent_for" do
    it "returns the other correspondent to the one given" do
      sender = create(:user)
      recipient = create(:user)
      conversation = create(:conversation, sender: sender, recipient: recipient)

      expect(conversation.other_correspondent_for(sender)).to eq(recipient)
      expect(conversation.other_correspondent_for(recipient)).to eq(sender)
    end
  end
end
