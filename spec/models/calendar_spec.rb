require 'rails_helper'

RSpec.describe Calendar, type: :model do
  describe '#date' do
    subject { described_class.new(dtstart: Time.now) }
    it 'is the date for the calendar entry' do
      expect(subject.date).to eq Time.now.to_date
    end
  end

  describe '#open?' do
    let(:open_event) { described_class.new(closed: false) }
    let(:closed_event) { described_class.new(closed: true) }

    it 'indicates whether the library is open at all during that time' do
      expect(open_event).to be_open
      expect(closed_event).not_to be_open
    end
  end

  describe '#open_24h' do
    subject { described_class.new(dtstart: Time.now.midnight, dtend: Time.now.end_of_day) }

    it 'opens 24 hours a day if the library opens at midnight and "closes" the end of the day' do
      expect(subject).to be_open_24h
    end
  end

  describe '.week' do
    it 'parses an ISO 8601 week-based year and week number into a range' do
      expect(described_class.week('2015W05')).to eq Date.parse('2015-01-25')...Date.parse('2015-02-01')
    end
  end
end
