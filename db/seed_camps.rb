[{ code: "8237241", name: "Newtown PA Summer Intensive 2015" },
 { code: "7723846", name: "Andover MA Summer Intensive 2015" },
 { code: "4111021", name: "Winnetka IL Summer Intensive 2015" },
 { code: "2643447", name: "BBT Industry at Roosevelt University" },
 { code: "GRSUMMER15", name: "Grand Rapids MI Summer Intensive 2015"}].each do |attrs|
   Camp.find_by(code: attrs[:code]) || Camp.create(attrs)
 end
