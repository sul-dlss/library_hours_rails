crumb :lib_home do
  link 'Stanford Libraries home', 'https://library.stanford.edu/'
end

crumb :root do
  link 'Library hours', root_path
  parent :lib_home
end

crumb :library do |library|
  link library.name, library_path(library)
  parent :root
end

crumb :location do |location|
  link location.name, library_location_path(location.library, location)
  parent location.library
end
