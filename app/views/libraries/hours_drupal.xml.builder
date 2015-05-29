xml.instruct!
xml.libraryHours do
  @libraries.each do |library|
    library.locations.each do |location|
      location.hours(@range).each do |cal|
        xml.entry do
          xml.id "#{library.to_param}-#{location.to_param}-#{cal.dtstart.strftime('%Y-%m-%d')}"
          xml.libraryNodeId library.node_mapping.node_id
          xml.locationNodeId location.node_mapping.node_id
          xml.opensAt cal.dtstart.to_i
          xml.closesAt cal.dtend.to_i
          xml.status cal.closed? ? '0' : '1'
          xml.librarySlug library.slug
          xml.locationSlug location.slug
        end
      end
    end
  end
end
