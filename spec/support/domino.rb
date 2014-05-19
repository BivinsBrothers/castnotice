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
    selector "#filter-region .calendar-checkbox"

    def self.select_region_id(region_id)
      page.find("#filter-region-#{region_id}").trigger('click')
    end

    def name
      node.find("label").text
    end
  end

  class CalendarProjectType < Domino
    selector "#filter-project .calendar-checkbox"

    def name
      node.find("label").text
    end
  end

  class CalendarUnion < Domino
    selector "#filter-union .calendar-checkbox"

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

    def gender
      node.find(".gender").text.partition("Gender: ").last
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

    def additional_project_info
      node.find(".additional-project-info").text.partition("Additional Project Info: ").last
    end

    def project_type_details
      node.find(".project-type-details").text.partition("Project Type Details: ").last
    end

    def start_date
      node.find(".start-date").text.partition("Shoot/Start Date: ").last
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
end
