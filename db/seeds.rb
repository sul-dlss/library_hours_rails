# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Library.find_or_create_by(slug: "green", name: 'Cecil H. Green Library', about_url: "https://library.stanford.edu/libraries/cecil-h-green-library",
                          locations: [Location.new(name: 'Access Services Department', slug: 'access-services-department')])
Library.find_or_create_by(slug: "ars", name: 'Archive of Recorded Sound', about_url: "https://library.stanford.edu/libraries/archive-recorded-sound")
Library.find_or_create_by(slug: "art", name: 'Art & Architecture Library (Bowes)', about_url: "https://library.stanford.edu/libraries/bowes-art-architecture-library")
Library.find_or_create_by(slug: "business", name: 'Business Library', about_url: "https://www.gsb.stanford.edu/library")
Library.find_or_create_by(slug: "eal", name: 'East Asia Library', about_url: "https://library.stanford.edu/libraries/east-asia-library")
Library.find_or_create_by(slug: "cubberley", name: 'Cubberley Education Library', about_url: "https://library.stanford.edu/libraries/cubberley-education-library")
Library.find_or_create_by(slug: "englib", name: 'Terman Engineering Library', about_url: "https://library.stanford.edu/libraries/terman-engineering-library")
Library.find_or_create_by(slug: "hila", name: 'Hoover Institution Library & Archives', about_url: "https://www.hoover.org/library-archives")
Library.find_or_create_by(slug: "hoover", name: 'Hoover Institution Library & Archives', about_url: "https://www.hoover.org/library-archives")
Library.find_or_create_by(slug: "law", name: 'Robert Crown Law Library', about_url: "https://law.stanford.edu/robert-crown-law-library/")
Library.find_or_create_by(slug: "hopkins", name: 'Harold A. Miller Library at Hopkins Marine Station', about_url: "https://library.stanford.edu/libraries/harold-miller-library-hopkins-marine-station")
Library.find_or_create_by(slug: "lane", name: 'Lane Medical Library', about_url: "https://lane.stanford.edu/index.html")
Library.find_or_create_by(slug: "music", name: 'Music Library', about_url: "https://library.stanford.edu/libraries/music-library")
Library.find_or_create_by(slug: "spc", name: 'Special Collections', about_url: "https://library.stanford.edu/libraries/special-collections")
Library.find_or_create_by(slug: "philosophy", name: 'Tanner Philosophy Library', about_url: "https://library.stanford.edu/libraries/tanner-philosophy-library")
Library.find_or_create_by(slug: "Rumsey", name: 'David Rumsey Map Center', about_url: "https://library.stanford.edu/libraries/david-rumsey-map-center")
Library.find_or_create_by(slug: "science", name: 'Robin Li and Melissa Ma Science Library', about_url: "https://library.stanford.edu/libraries/robin-li-and-melissa-ma-science-library")
Library.find_or_create_by(slug: "srwc", name: 'Academy Hall (SRWC)', about_url: "https://library.stanford.edu/libraries/academy-hall-redwood-city-campus")


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
