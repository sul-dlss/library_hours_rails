xml.instruct!
xml.libraryHours do
  @libraries.each do |library|
    library.locations.with_hours.each do |location|
      next unless location.node_mapping

      location.hours(@range).each do |cals|
        cals.reject { |cal| cal.is_a? MissingCalendar }.each do |cal|
          xml.entry do
            xml.id "#{library.to_param}-#{location.to_param}-#{cal.dtstart.strftime('%Y-%m-%d')}"
            xml.libraryNodeId library.node_mapping.node_id
            xml.locationNodeId location.node_mapping.node_id
            xml.opensAt cal.dtstart.to_i
            xml.closesAt cal.dtend_drupal.to_i
            xml.status cal.status_drupal
            xml.librarySlug library.slug
            xml.locationSlug location.slug
          end
        end
      end
    end
  end
end
