class CategorySeed
  require "csv"

  def self.generate_from_csv(klasses)
    klasses.each do |klass|
      filename = klass.name.underscore.pluralize
      CSV.foreach(Rails.root.join("db/categories/#{filename}.csv"), headers: true) do |row|
        attrs = row.to_hash.each {|k, v| v.strip! }
        klass.create_with(attrs.except(:name)).find_or_create_by!(name: attrs["name"])
      end
    end
  end

  def self.generate_project_type
    CSV.foreach(Rails.root.join("db/categories/project_types.csv"), headers: true) do |row|
      attrs = row.to_hash.each {|k, v| v.strip! }
      pj = ProjectType.find_by_name(attrs["name"])
      if pj.present?
        pj.update_attributes(display_order: attrs["display_order"])
      else
        ProjectType.create(name: attrs['name'], display_order: attrs["display_order"])
      end
    end
  end

end


# Generate Regions
Region::DEFAULTS.each do |r|
  Region.find_or_create_by!(name: r)
end

CategorySeed.generate_from_csv([
  Union,
  Accent,
  AthleticEndeavor,
  Disability,
  DisabilityAssistiveDevice,
  Ethnicity,
  FluentLanguage,
  PerformanceSkill,
  Region
])

CategorySeed.generate_project_type
