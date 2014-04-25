require "spec_helper"

describe "user messaging" do
  it 'a user can see new messages in header' do
    user = create(:user)
    bob = build(:user, email: 'bob@fake.com', name: 'Bob', password: "goodpassword", birthday: "1969-1-1", tos: "1")
    
    log_in user
    visit messages_path
    
    expect(page).to have_content("Messages (0)")

    conversation = build(:conversation, subject: "new message", to: user.id, from: bob.id)
    build(:message, conversation_id: 1, body: "This is a message.")
    visit messages_path

    expect(page).to have_content("Messages (1)")
    
    
    
  end
  it 'messages show conversations to and from the logged in user' do
    user = create(:user)
    bob = build(:user, email: 'bob@fake.com', name: 'Bob')

    log_in user
    visit messages_path
    expect(page).to have_content("You have no messages")


    conversation = build(:conversation, subject: "new message", to: user.id, from: bob.id)
    build(:message, conversation_id: 1, body: "This is a message.")
    
    
    
    visit messages_path
    
    expect(page).to have_content("Messages (1)")
    
  end
  
end
