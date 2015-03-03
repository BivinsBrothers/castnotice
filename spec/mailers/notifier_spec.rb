require "spec_helper"

describe Notifier do
  describe "allows user to contact CastNotice via email" do
    let(:mail) { Notifier.contact_us('George',
                                     'test@fake.com',
                                     'Need Information',
                                     'Discounts for Broadway Breakthrough participants?') }

    before do
      env = double(:env, castnotice_admin_email: "test@fake.com")
      allow(Figaro).to receive(:env).and_return(env)
    end

    it 'sends the email' do
      expect(mail.to).to eq(['test@fake.com'])
    end

    it 'sends the email with subject' do
      expect(mail.subject).to eq('Need Information')
    end

    it 'email contains from_name' do
      expect(mail.body).to have_content('George')
    end

    it 'email contains from_email' do
      expect(mail.body).to have_content("test@fake.com")
    end

    it 'email contains email content' do
      expect(mail.body).to have_content("Discounts for Broadway Breakthrough participants?")
    end

  end
end
