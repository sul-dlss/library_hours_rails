# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spreadsheet, type: :model do
  let(:location) { create(:location) }
  describe '#import' do
    let(:content) do
      Tempfile.new.tap do |f|
        f.puts <<~EOF.strip
          garbage,row,i,don't,even...
          ,,,,#{location.slug},
          Date,Day,Type,Notes,Open,Closed
          2015-05-22,Friday,Regular,Day,8:00 AM,9:00PM
        EOF
        f.rewind
      end
    end

    before do
      subject.attachment.attach io: content, filename: 'x.csv', content_type: 'text/plain'
      subject.save
    end
    it 'imports the spreadsheet hours into calendar events' do
      expect { subject.import }.to change(Calendar, :count).by(1)
      expect(location.calendars.length).to eq 1
      event = location.calendars.first

      expect(event.date).to eq Date.parse('2015-05-22')
      expect(event.summary).to eq 'Regular'
      expect(event.description).to eq 'Day'
      expect(event.dtstart).to eq Time.zone.parse('2015-05-22T08:00:00')
      expect(event.dtend).to eq Time.zone.parse('2015-05-22T21:00:00')
    end
  end
end
