# Generate Regions
Region::DEFAULTS.each do |r|
  unless Region.find_by_name(r)
    Region.create(name: r)
  end
end

# Generate Project Types
File.open("#{Rails.root}/db/categories/project_types.txt", "r") do |f|
  f.each_line do |line|
    project_type = line.chomp
    unless ProjectType.find_by_name(project_type)
      ProjectType.create(name: project_type)
    end
  end
end
