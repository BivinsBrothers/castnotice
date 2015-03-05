require 'spec_helper'

feature "camper registration", mysql: true do
  let(:mysql_conn) { MysqlConnection.create }

  def select_date(date, options = {})
    label = find("label", text: options[:from])
    field = label["for"]
    select date.year.to_s,   :from => "#{field}_1i"
    select Date::MONTHNAMES[date.month], :from => "#{field}_2i"
    select date.day.to_s,    :from => "#{field}_3i"
  end

  before do
    clear_emails
    mysql_conn.query("delete from ec_order")
    mysql_conn.query("delete from ec_orderdetail")
  end

  def ensure_order!(id)
    existing = mysql_conn.query "select order_id from ec_order where order_id=#{id}"
    if existing.none?
      mysql_conn.query <<-SQL
        insert into ec_order(order_id)
        values (#{id});
      SQL
    end
  end

  def create_order_detail!(attrs)
    order_id, model_number, quantity = attrs.values_at(:order_id, :model_number, :quantity)
    ensure_order!(order_id)
    mysql_conn.query <<-SQL
      insert into ec_orderdetail(order_id, model_number, quantity, image1)
      values(#{order_id}, '#{mysql_conn.escape(model_number)}', #{quantity}, '')
    SQL
  end

  let!(:camp) { Camp.create(name: "A camp", code: "GREAT2011") }

  def fill_in_student_fields(name, email)
    fill_in "Full Name", with: name
    fill_in "Email", with: email
    fill_in "Address One", with: "123 Example st"
    fill_in "City", with: "Nowhere"
    select "Illinois", from: "State"
    fill_in "Zip Code", with: "43212"
    select_date Date.today, from: "Birthday"
    fill_in "School", with: "Ridgmont High"
    select "11", from: "Grade"
    select "Male", from: "Gender"
    fill_in "Student's home phone", with: "213-123-1123"
    fill_in "Student's cell phone", with: "213-123-1123"

    fill_in "Parents Fullname", with: "Parent Person"
    fill_in "Parents Email", with: "parent1@example.com"
    fill_in "Parents Street Address", with: "123 H Ln"
    fill_in "Parents Suite/Apt", with: "2"
    fill_in "Parents City", with: "Fargo"
    select "North Dakota", from: "Parents State"
    fill_in "Parents Zip", with: "83812"
    fill_in "Parents Phone", with: "773-123-1123"

    fill_in "Emergency contact (if different than parent)", with: "Jim Beam"
    fill_in "Emergency contact phone", with: "800-123-1234"
    fill_in "Emergency contact relationship", with: "Favorite drink"
    fill_in "Student's medical history", with: "I have no history"
    fill_in "Current medication", with: "Advil, twice daily"
    fill_in "Allergies", with: "Pollen"
    select "Adult Medium", from: "Shirt size"
    fill_in "Referred by another student?", with: "My BFF"
    check "I agree to the terms of service"
    check "I agree to the refund policy"
    check "I agree to the photo release"
    check "I accept the medical release"
  end

  scenario "after successful order" do
    create_order_detail! order_id: 1, quantity: 2, model_number: camp.code
    visit new_camper_registration_path(order_id: 1)
    expect(page).to have_content("Order 1")

    within :xpath, ".//form//fieldset[1]" do
      fill_in_student_fields("John Bonham", "john@example.com")
    end

    within :xpath, ".//form//fieldset[2]" do
      fill_in_student_fields("Josie Bonham", "josie@example.com")
    end

    fill_in "How did you hear about BBT", with: "My best friend"
    fill_in "Friend's name", with: "My best friend"
    fill_in "Friend's email", with: "foo@bar.com"

    click_on "Register"

    expect(page).to have_content "Thank you!"

    expect(emails_sent_to('john@example.com').size).to eq(1)
    expect(emails_sent_to('josie@example.com').size).to eq(1)


    admin = create(:user, :admin)
    log_in admin
    within "header nav" do
      click_on "Camps"
    end

    expect(page).to have_selector("h1", text: "Camps")
    within ".main-content" do
      expect(page).to have_content "2 campers are fully registered"
      click_link "download roster"
    end

    expect(page).to have_content "John Bonham"
  end

  scenario "with existing users" do
    create_order_detail! order_id: 1, quantity: 2, model_number: camp.code
    create(:user, email: "john@example.com", sign_in_count: 3)
    clear_emails

    visit new_camper_registration_path(order_id: 1)
    expect(page).to have_content("Order 1")

    within :xpath, ".//form//fieldset[1]" do
      fill_in_student_fields("John Bonham", "john@example.com")
    end

    within :xpath, ".//form//fieldset[2]" do
      fill_in_student_fields("Josie Bonham", "josie@example.com")
    end

    fill_in "How did you hear about BBT", with: "My best friend"

    click_on "Register"

    expect(page).to have_content "Thank you!"
    expect(User.count).to eq(2)
    expect(emails_sent_to('john@example.com').size).to eq(0)
    expect(emails_sent_to('josie@example.com').size).to eq(1)
  end
end
