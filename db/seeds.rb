# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

client = Hurley::Client.new 'https://library.stanford.edu/'

response = client.get('/libraries')

doc = Nokogiri::HTML(response.body)

doc.css('.views-row').each do |row|
  title = row.css('.views-field-title').text.strip
  slug = row.css('.views-field-field-branch-image').css('a').attr('href').value.gsub(%r{^/libraries/}, '').gsub(%r{/about$}, '').strip
  library = Library.find_or_create_by(slug: slug, name: title)

  about_response = client.get("/libraries/#{slug}/about")

  about_doc = Nokogiri::HTML(about_response.body)

  node_id = about_doc.css('body').attr('class').value.scan(/page-node-(\d+)/).flatten.first

  NodeMapping.find_or_create_by(mapped: library, node_id: node_id)

  about_doc.css('.view-sulair-places table tbody tr').each do |place_row|
    place_title = place_row.css('.views-field-title')
    place_name = place_title.text.strip
    place_href = place_title.css('a').attr('href')
    place_slug = place_href.value.split('/').last.strip
    location = Location.find_or_create_by(library: library, slug: place_slug, name: place_name)

    place_response = client.get(place_href)

    place_doc = Nokogiri::HTML(place_response.body)
    node_id = place_doc.css('body').attr('class').value.scan(/page-node-(\d+)/).flatten.first
    NodeMapping.find_or_create_by(mapped: location, node_id: node_id)
  end
end

{
  7 => 'information_center',
  12 => 'green_library',
  14 => 'media_microtext',
  15 => 'green_loan',
  20 => 'ssds_walk_in',
  21 => 'ssds_velma',
  22 => '24_hour_study_room',
  24 => 'digital_language_lab',
  27 => 'tech_lounge_circulation',
  28 => 'ars_archive',
  32 => 'art_library',
  33 => 'art_ref',
  34 => 'art_vrc',
  37 => 'biology_library',
  38 => 'biology_ref',
  39 => 'business_library',
  41 => 'chemistry_library',
  42 => 'chemistry_ref',
  43 => 'classics_lib_circ',
  48 => 'earth_sciences_library',
  49 => 'earth_sciences_ref',
  51 => 'east_asia_library',
  52 => 'east_asia_ref',
  56 => 'education_library',
  57 => 'education_ref',
  60 => 'engineering_library',
  61 => 'engineering_ref',
  62 => 'hv_archives',
  63 => 'hv_library',
  64 => 'law_library',
  65 => 'law_ref',
  67 => 'marine_biology_library',
  69 => 'math_stats_library',
  72 => 'math_stats_ref',
  73 => 'medical_library',
  74 => 'music_library',
  77 => 'music_ref',
  78 => 'slac_library',
  79 => 'spec_coll_reading',
  80 => 'sal12_library',
  81 => 'tanner_lib_circ'
}.each do |location_id, old_slug|
  location = Location.find(location_id)
  FriendlyId::Slug.find_or_create_by slug: old_slug, sluggable: location
end
