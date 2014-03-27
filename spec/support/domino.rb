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
end