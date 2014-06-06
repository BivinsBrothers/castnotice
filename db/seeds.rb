class CategorySeed
  require "csv"

  def self.generate_from_csv(klasses)
    klasses.each do |klass|
      filename = klass.name.underscore.pluralize
      CSV.foreach(Rails.root.join("db/categories/#{filename}.csv"), headers: true) do |row|
        attrs = row.to_hash
        klass.create_with(attrs.except(:name)).find_or_create_by!(name: attrs["name"])
      end
    end
  end
end

# Generate Regions
Region::DEFAULTS.each do |r|
  Region.find_or_create_by!(name: r)
end

CategorySeed.generate_from_csv([
  ProjectType,
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
