module Dom
  class Headshots < Domino
    selector ".headshot"

    def delete!
      click_link "Delete"
    end

    def set_as_background
      click_link "Set as background"
    end

    def background?
      node.has_content?("Current background")
    end
  end

  class Video < Domino
    selector ".video"
  end

  class CalendarDatepicker < Domino
    selector "#calendar-datepicker"

    def month
      node.find(".ui-datepicker-month").text
    end

    def year
      node.find(".ui-datepicker-year").text
    end

    def next_month
      node.find(".ui-datepicker-next").click
    end

    def previous_month
      node.find(".ui-datepicker-prev").click
    end
  end

  class CalendarRegion < Domino
    selector "#filter-0 .calendar-checkbox"

    def self.select_region_id(region_id)
      page.find("#filter-0-#{region_id}").trigger('click')
    end

    def name
      node.find("label").text
    end
  end

  class CalendarProjectType < Domino
    selector "#filter-1 .calendar-checkbox"

    def name
      node.find("label").text
    end
  end

  class CalendarUnion < Domino
    selector "#filter-2 .calendar-checkbox"

    def name
      node.find("label").text
    end
  end

  class CalendarEvent < Domino
    selector ".calendar-event"

    attribute :project_title, ".calendar-name"

    def audition_date
      "#{node.find(".calendar-month").text} #{node.find(".calendar-day").text}"
    end

    def paid?
      node.has_css? ".calendar-paid-true"
    end

    def stipend?
      node.has_css? ".calendar-stipend-true"
    end

    def region
      node.find(".region").text.partition("Region: ").last
    end

    def project_type
      node.find(".project-type").text.partition("Project Type: ").last
    end

    def unions
      node.find(".unions").text.partition("Unions: ").last
    end

    def casting_director
      node.find(".casting-director").text.partition("Casting Director: ").last
    end

    def location
      node.find(".location").text.partition("Location: ").last
    end

    def production_location
      node.find(".production_location").text.partition("Production Location: ").last
    end

    def gender
      node.find(".gender").text.partition("Gender: ").last
    end

    def age_min
      node.find(".age-min").text.partition("Age Min: ").last
    end

    def age_max
      node.find(".age-max").text.partition("Age Max: ").last
    end

    def storyline
      node.find(".storyline").text.partition("Storyline: ").last
    end

    def character_description
      node.find(".character-description").text.partition("Description: ").last
    end

    def how_to_audition
      node.find(".how-to-audition").text.partition("How to Audition: ").last
    end

    def special_notes
      node.find(".special-notes").text.partition("Special Notes: ").last
    end

    def more_information
      node.find(".calendar-detail").text
    end

    def toggle_more_information
      node.find(".calendar-shrink").click
    end

    def click_edit
      node.click_link("Edit")
    end

    def click_delete
      node.click_link("Delete")
    end

    def manage_roles
      node.click_link("Manage Roles")
    end
  end

  class CalendarEventRole < Domino
    selector ".role"

    attribute :description

    def edit
      click_link "Edit"
    end

    def delete
      click_link "Delete"
    end

    def view_details
      click_link "View"
    end
  end

  class SearchResult < Domino
    selector ".result"

    attribute :name
    attribute :descriptive_tag
    attribute :performer_type
  end

  class SearchForm < Domino
    selector "#search-form"

    def submit
      page.execute_script("document.getElementById('search-form').submit();")
    end
  end

  class MessageHeader < Domino
    selector "#message-header"

    def unread_message
      node.text
    end

    def click
      node.find("a").click
    end
  end

  class Conversation < Domino
    selector ".conversation"

    attribute :correspondent

    def subject
      node.find(".subject").text
    end

    def correspondent
      node.find(".from").text
    end

    def unread?
      node.has_css? ".unread"
    end

    def messages
      Dom::Message.all
    end

    def click
      node.find(".conversation-detail.subject").click
    end
  end

  class NewConversation < Domino
    selector ".new_conversation"

    attribute :correspondent
    attribute :subject

    def message
      Dom::Message.first
    end
  end

  class ReplyMessage < Domino
    selector ".reply-conversation"

    attribute :correspondent
    attribute :subject
    attribute :in_reply_to

    def message=(message)
      fill_in "Message", with: message
    end

    def reply
      click_button "Reply"
    end
  end

  class Message < Domino
    selector ".conversation-message, .new_conversation"

    attribute :correspondent
    attribute :body, ".body"

    def body=(message)
      fill_in "Message", with: message
    end

    def subject=(string)
      fill_in "Subject", with: string
    end

    def send
      click_button "Send"
    end
  end

  class AccountInformation < Domino
    selector ".account-information"

    def current_subscription_plan
      node.find(".plan-information").text.partition("Plan Level: ").last
    end

    def admin_account
      node.find("#account_type").text
    end

    def full_name
      find_field("Full Name").value
    end

    def email
      find_field("Email").value
    end

    def location_address
      find_field("Address One").value
    end

    def location_address_two
      find_field("Address Two").value
    end

    def location_city
      find_field("City").value
    end

    def location_state
      find_field("State").value
    end

    def location_zip
      find_field("Zip Code").value
    end

    def birthday_year
      find_field("user_birthday_1i").value
    end

    def birthday_month
      find_field("user_birthday_2i").value
    end

    def birthday_day
      find_field("user_birthday_3i").value
    end

    def parent_name
      find_field("Parents Fullname").value
    end

    def parent_email
      find_field("Parents Email").value
    end

    def parent_location
      find_field("Parents Street Address").value
    end

    def parent_location_two
      find_field("Parents Suite/Apt").value
    end

    def parent_city
      find_field("Parents City").value
    end

    def parent_state
      find_field("Parents State").value
    end

    def parent_zip
      find_field("Parents Zip Code").value
    end

    def parent_phone
      find_field("Parents Phone").value
    end
  end
end
