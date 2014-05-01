# Generate Regions
Region.delete_all
Region::DEFAULTS.each { |r| Region.create(name: r) }
