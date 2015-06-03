require 'rails_helper'

RSpec.describe Spreadsheet, type: :model do
  let(:location) { create(:location) }
  describe '#import' do
    let(:content) do
      <<-EOF
garbage,row,i,don't,even...
,,,,#{location.slug},
Date,Day,Type,Notes,Open,Closed
2015-05-22,Friday,Regular,Day,8:00 AM,9:00PM
      EOF
    end

    before do
      subject.attachment = StringIO.new(content.strip)
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
