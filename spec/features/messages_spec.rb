require "spec_helper"

feature "talent messaging" do
  let(:user) { create(:user) }
  let(:mentor) { create(:user, mentor: true) }

  context "as a regular user" do
    before do
      log_in user
    end

    scenario "a user sees unread count in header" do
      conversation = create(:conversation, recipient: user)
      create(:message, recipient: user, conversation: conversation)

      visit dashboard_path

      header = Dom::MessageHeader.first
      expect(header.unread_message).to eq("You have 1 new message")
    end

    scenario "a user can view a list of all their conversations" do
      conversation1 = create(:conversation, recipient: user, subject: "Finding words")
      conversation1.messages << build(:message)
      conversation2 = create(:conversation, recipient: user, subject: "Umbrellas")
      conversation2.messages << build(:message)
      conversation3 = create(:conversation, sender: user, subject: "Doesn't matter")
      conversation3.messages << build(:message)

      conversation1.messages.first.update_attributes(recipient_read_at: 7.days.ago)
      conversation1.update_attributes(recent_message_created_at: 14.days.ago)
      conversation2.update_attributes(recent_message_created_at: 7.days.ago)
      conversation3.update_attributes(recent_message_created_at: 1.day.ago)

      visit dashboard_path

      Dom::MessageHeader.first.click

      expect(page).to have_content("My Messages")
      conversations = Dom::Conversation.all

      expect(conversations.count).to eq(3)

      expect(conversations[0].subject).to eq("Doesn't matter")
      expect(conversations[0].correspondent).to eq(conversation3.recipient.name)
      expect(conversations[0].unread?).to be_false

      expect(conversations[1].subject).to eq("Umbrellas")
      expect(conversations[1].correspondent).to eq(conversation2.sender.name)
      expect(conversations[1].unread?).to be_true

      expect(conversations[2].subject).to eq("Finding words")
      expect(conversations[2].correspondent).to eq(conversation1.sender.name)
      expect(conversations[2].unread?).to be_false
    end

    scenario "a user can write a message to another user" do
      recipient = create(:user, name: "Joaquin Phoenix")

      visit public_resume_path(recipient.resume)

      click_link "Send Message"

      expect(page).to have_content("New Message")

      conversation = Dom::NewConversation.first

      expect(conversation.correspondent).to eq("Joaquin Phoenix")

      conversation.message.body = "It's a nice day, today"
      conversation.message.subject = "Flowers"
      conversation.message.send

      expect(page).to have_content("Conversation with Joaquin Phoenix")
      expect(page).to have_content("Your message has been sent")

      conversation_thread = Dom::Conversation.first

      expect(conversation_thread.subject).to eq("Flowers")
      expect(conversation_thread.correspondent).to eq("Joaquin Phoenix")
      expect(conversation_thread.messages.first.body).to eq("It's a nice day, today")
    end

    scenario "a user can respond to a message they have received" do
      sender = create(:user, name: "Chris Farley")
      conversation = create(:conversation, sender: sender, recipient: user)
      conversation.messages << build(:message)

      visit conversations_path

      dom_conversation = Dom::Conversation.first

      dom_conversation.click

      expect(current_path).to eq(conversation_path(conversation))

      reply = Dom::ReplyMessage.first
      reply.message = "We should probably make a game about legos and cows"
      reply.reply

      expect(page).to have_content("Your reply has been sent")

      dom_conversation = Dom::Conversation.first
      expect(dom_conversation.messages.count).to eq(2)
      expect(page).to have_content("We should probably make a game about legos and cows")
    end

    scenario "a user cannot send messages to himself or herself" do
      visit public_resume_path(user.resume)

      expect(page.text).not_to include("Send Message")
    end
  end

  context "as a mentor" do
    before do
      log_in mentor
    end

    scenario "mentors cannot see unread count in header" do
      expect(page.text).not_to include("You have 0 new messages")
    end

    scenario "mentors cannot send messages to users" do
      visit public_resume_path(user.resume)

      expect(page.text).not_to include("Send Message")
    end
  end

end
