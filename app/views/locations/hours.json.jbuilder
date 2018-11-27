# frozen_string_literal: true

json.links do
  json.self url_for(params.to_unsafe_h.merge(only_path: false))
  json.prev url_for(from: (@range.begin - @range.to_a.length.days), to: @range.begin, only_path: false)
  json.next url_for(from: @range.end, to: (@range.end + @range.to_a.length.days), only_path: false)
end
json.data do
  json.id "#{@location.library.to_param}/#{@location.to_param}"
  json.type @location.class.to_s

  json.attributes do
    json.name @location.name
    json.hours do
      json.array! @hours do |c|
        json.opens_at c.first.dtstart.localtime
        json.closes_at c.first.dtend.localtime
        json.type c.first.summary.to_s
        json.notes c.first.description.to_s
        json.open c.first.open?
      end
    end
  end

  json.relationships do
    json.library do
      json.links do
        json.related library_url(@location.library)
      end
      json.data do
        json.id @location.library.to_param
        json.attributes do
          json.name @location.library.name
        end
      end
    end
  end
end
