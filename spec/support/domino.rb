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

  class CalendarEvent < Domino
    selector ".calendar-event"

    attribute :name, ".calendar-name"

    def audition_date
      "#{node.find(".calendar-month").text} #{node.find(".calendar-day").text}"
    end

    def paid?
      node.has_css? ".calendar-paid-true"
    end

    def region
      node.find(".region").text.partition("Region: ").last
    end

    def performer_type
      node.find(".performer-type").text.partition("Performer Type: ").last
    end

    def project_type
      node.find(".project-type").text.partition("Project Type: ").last
    end

    def character
      node.find(".character").text.partition("Character: ").last
    end

    def pay
      node.find(".pay").text.partition("Pay Rate: ").last
    end

    def union
      node.find(".union").text.partition("Union Status: ").last
    end

    def director
      node.find(".director").text.partition("Casting Director: ").last
    end

    def story
      node.find(".story").text.partition("Storyline: ").last
    end

    def description
      node.find(".description").text.partition("Description: ").last
    end

    def audition
      node.find(".audition").text.partition("How to Audition: ").last
    end

    def start_date
      node.find(".start-date").text.partition("Shoot/Start Date: ").last
    end

    def end_date
      node.find(".end-date").text.partition("Shoot/End Date: ").last
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
  end
end