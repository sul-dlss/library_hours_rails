# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

library_data = [{"name"=>"Cecil H. Green Library",
  "slug"=>"green",
  "public"=>true,
  "about_url"=>"https://library.stanford.edu/libraries/cecil-h-green-library",
  "locations"=>
   [{"name"=>"Reference", "slug"=>"reference", "keeps_hours"=>true, "primary"=>false},
    {"name"=>"Library & circulation", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true},
    {"name"=>"Media Center", "slug"=>"media-microtext-center", "keeps_hours"=>true, "primary"=>false}]},
 {"name"=>"Lathrop Library", "slug"=>"lathrop", "public"=>true, "about_url"=>nil, "locations"=>[{"name"=>"Learning Hub", "slug"=>"tech-lounge", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Archive of Recorded Sound",
  "slug"=>"ars",
  "public"=>true,
  "about_url"=>"https://library.stanford.edu/libraries/archive-recorded-sound",
  "locations"=>[{"name"=>"Reference & reading room", "slug"=>"archive-recorded-sound", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Art & Architecture Library (Bowes)",
  "slug"=>"art",
  "public"=>true,
  "about_url"=>"https://library.stanford.edu/libraries/bowes-art-architecture-library",
  "locations"=>
   [{"name"=>"Library & circulation", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true},
    {"name"=>"Reference", "slug"=>"reference", "keeps_hours"=>true, "primary"=>false},
    {"name"=>"Visual Resources Center", "slug"=>"visual-resources-center", "keeps_hours"=>true, "primary"=>false}]},
 {"name"=>"Business Library",
  "slug"=>"business",
  "public"=>true,
  "about_url"=>"https://www.gsb.stanford.edu/library",
  "locations"=>[{"name"=>"Library & circulation", "slug"=>"library-i-desk", "keeps_hours"=>true, "primary"=>true}, {"name"=>"Reference", "slug"=>"virtual-support", "keeps_hours"=>true, "primary"=>false}]},
 {"name"=>"Classics Library", "slug"=>"classics-library", "public"=>true, "about_url"=>nil, "locations"=>[{"name"=>"Library & circulation", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Earth Sciences Library & Map Collections (Branner)",
  "slug"=>"branner",
  "public"=>true,
  "about_url"=>nil,
  "locations"=>[{"name"=>"Library & circulation", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true}, {"name"=>"Reference", "slug"=>"reference", "keeps_hours"=>true, "primary"=>false}]},
 {"name"=>"East Asia Library", "slug"=>"eal", "public"=>true, "about_url"=>"https://library.stanford.edu/libraries/east-asia-library", "locations"=>[{"name"=>"Library & circulation", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Education Library (Cubberley)",
  "slug"=>"cubberley",
  "public"=>true,
  "about_url"=>"https://library.stanford.edu/libraries/cubberley-education-library",
  "locations"=>[{"name"=>"Library & circulation", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Engineering Library (Terman)",
  "slug"=>"englib",
  "public"=>true,
  "about_url"=>"https://library.stanford.edu/libraries/terman-engineering-library",
  "locations"=>[{"name"=>"Library & circulation", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Hoover Institution Library & Archives", "slug"=>"hila", "public"=>true, "about_url"=>"https://www.hoover.org/library-archives", "locations"=>[{"name"=>"Reading Room, reservation required", "slug"=>"reference", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Law Library (Robert Crown)",
  "slug"=>"law",
  "public"=>true,
  "about_url"=>"https://law.stanford.edu/robert-crown-law-library/",
  "locations"=>[{"name"=>"Library building", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true}, {"name"=>"Virtual support", "slug"=>"reference", "keeps_hours"=>true, "primary"=>false}]},
 {"name"=>"Marine Biology Library (Harold A. Miller) at Hopkins Marine Station",
  "slug"=>"hopkins",
  "public"=>true,
  "about_url"=>"https://library.stanford.edu/libraries/harold-miller-library-hopkins-marine-station",
  "locations"=>[{"name"=>"Library & circulation", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Medical Library (Lane)", "slug"=>"lane", "public"=>true, "about_url"=>"https://lane.stanford.edu/index.html", "locations"=>[{"name"=>"Library & circulation", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Music Library", "slug"=>"music", "public"=>true, "about_url"=>"https://library.stanford.edu/libraries/music-library", "locations"=>[{"name"=>"Library & circulation", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"SLAC National  Accelerator Lab Research Library", "slug"=>"slac", "public"=>false, "about_url"=>nil, "locations"=>[{"name"=>"Library & circulation", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Special Collections",
  "slug"=>"spc",
  "public"=>true,
  "about_url"=>"https://library.stanford.edu/libraries/special-collections",
  "locations"=>[{"name"=>"Field Reading Room, by appointment only", "slug"=>"field-reading-room", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Stanford Auxiliary Library 1&2 (SAL1&2)", "slug"=>"sal", "public"=>false, "about_url"=>nil, "locations"=>[{"name"=>"Operations only, no access", "slug"=>"operations", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Stanford Auxiliary Library 3 (SAL3)", "slug"=>"sal3", "public"=>false, "about_url"=>nil, "locations"=>[{"name"=>"Operations only, no access", "slug"=>"operations", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Stanford Auxiliary Library, off-campus Newark", "slug"=>"newark", "public"=>false, "about_url"=>nil, "locations"=>[{"name"=>"Operations only, no access", "slug"=>"operations", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Philosophy Library (Tanner)",
  "slug"=>"philosophy",
  "public"=>true,
  "about_url"=>"https://library.stanford.edu/libraries/tanner-philosophy-library",
  "locations"=>[{"name"=>"Library & circulation", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"David Rumsey Map Center",
  "slug"=>"Rumsey",
  "public"=>true,
  "about_url"=>"https://library.stanford.edu/libraries/david-rumsey-map-center",
  "locations"=>[{"name"=>"Reference & circulation", "slug"=>"visitor-access", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Science Library (Li and Ma)",
  "slug"=>"science",
  "public"=>true,
  "about_url"=>"https://library.stanford.edu/libraries/robin-li-and-melissa-ma-science-library",
  "locations"=>[{"name"=>"Library & circulation", "slug"=>"library-circulation", "keeps_hours"=>true, "primary"=>true}]},
 {"name"=>"Academy Hall (SRWC)", "slug"=>"srwc", "public"=>true, "about_url"=>"https://library.stanford.edu/libraries/academy-hall-redwood-city-campus", "locations"=>[{"name"=>"Lobby desk", "slug"=>"lobby-desk", "keeps_hours"=>true, "primary"=>true}]}]

library_data.each do |data|
  Library.find_or_create_by(data.except('locations')) do |library|
    data['locations'].map { |x| library.locations.find_or_initialize_by(x) }
  end
end


[
  { term: 'Fall 2014',   quarter: 'Fall',   start_date: Date.new(2014, 1, 1), end_date: Date.new(2014, 12, 12) },

  { term: 'Winter 2015', quarter: 'Winter', end_date: Date.new(2015, 3, 20) },
  { term: 'Spring 2015', quarter: 'Spring', end_date: Date.new(2015, 6, 10) },
  { term: 'Summer 2015', quarter: 'Summer', end_date: Date.new(2015, 8, 15) },
  { term: 'Fall 2015',   quarter: 'Fall',   end_date: Date.new(2015, 12, 11) },

  { term: 'Winter 2016', quarter: 'Winter', end_date: Date.new(2016, 3, 18) },
  { term: 'Spring 2016', quarter: 'Spring', end_date: Date.new(2016, 6, 8) },
  { term: 'Summer 2016', quarter: 'Summer', end_date: Date.new(2016, 8, 13) },
  { term: 'Fall 2016',   quarter: 'Fall',   end_date: Date.new(2016, 12, 16) },

  { term: 'Winter 2017', quarter: 'Winter', end_date: Date.new(2017, 3, 24) },
  { term: 'Spring 2017', quarter: 'Spring', end_date: Date.new(2017, 6, 14) },
  { term: 'Summer 2017', quarter: 'Summer', end_date: Date.new(2017, 8, 19) },
  { term: 'Fall 2017',   quarter: 'Fall',   end_date: Date.new(2017, 12, 15) },

  { term: 'Winter 2018', quarter: 'Winter', end_date: Date.new(2018, 3, 23) },
  { term: 'Spring 2018', quarter: 'Spring', end_date: Date.new(2018, 6, 13) },
  { term: 'Summer 2018', quarter: 'Summer', end_date: Date.new(2018, 8, 18) },
  { term: 'Fall 2018',   quarter: 'Fall',   end_date: Date.new(2018, 12, 14) },

  { term: 'Winter 2019', quarter: 'Winter', end_date: Date.new(2019, 3, 22) },
  { term: 'Spring 2019', quarter: 'Spring', end_date: Date.new(2019, 6, 12) },
  { term: 'Summer 2019', quarter: 'Summer', end_date: Date.new(2019, 8, 17) },
  { term: 'Fall 2019',   quarter: 'Fall',   end_date: Date.new(2019, 12, 13) },

  { term: 'Winter 2020', quarter: 'Winter', end_date: Date.new(2020, 3, 20) },
  { term: 'Spring 2020', quarter: 'Spring', end_date: Date.new(2020, 6, 10) },
  { term: 'Summer 2020', quarter: 'Summer', end_date: Date.new(2020, 8, 15) }
].each do |t|
  Term.find_or_create_by(name: t[:quarter], dtstart: t[:start_date] || Term.last.dtend + 1.day, dtend: t[:end_date])
end

[
  { name: 'Martin Luther King, Jr. Day', dtstart: Date.new(2015, 1, 19) },
  { name: "Presidents' Day", dtstart: Date.new(2015, 2, 16) },
  { name: 'Memorial Day', dtstart: Date.new(2015, 5, 25) },
  { name: 'Independence Day', dtstart: Date.new(2015, 7, 3), dtend: Date.new(2015, 7, 4) },
  { name: 'Labor Day', dtstart: Date.new(2015, 9, 7) },
  { name: 'Thanksgiving Holiday', dtstart: Date.new(2015, 11, 26), dtend: Date.new(2015, 11, 27) },
  { name: 'Winter Holiday', dtstart: Date.new(2015, 12, 24), dtend: Date.new(2015, 12, 25) },
  { name: "New Year's Day", dtstart: Date.new(2016, 1, 1) }
].each do |t|
  Term.find_or_create_by(t.reverse_merge(dtend: t[:dtstart], holiday: true))
end
