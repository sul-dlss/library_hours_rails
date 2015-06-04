require 'rails_helper'

RSpec.describe Calendar, type: :model do
  describe '#date' do
    subject { described_class.new(dtstart: Time.zone.now) }
    it 'is the date for the calendar entry' do
      expect(subject.date).to eq Time.zone.now.to_date
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
    subject { described_class.new(dtstart: Time.zone.now.midnight, dtend: Time.zone.now.end_of_day) }

    it 'opens 24 hours a day if the library opens at midnight and "closes" the end of the day' do
      expect(subject).to be_open_24h
    end
  end

  describe '.week' do
    it 'parses an ISO 8601 week-based year and week number into a range' do
      expect(described_class.week('2015W05')).to eq Date.parse('2015-01-25')..Date.parse('2015-01-31')
    end
  end

  describe '#closed!' do
    subject { described_class.new(dtstart: Time.zone.now) }

    it 'marks an event as being closed' do
      expect { subject.closed! }.to change(subject, :open?).to(false)
      expect(subject.dtstart).to eq subject.dtend
    end
  end

  describe '#open_24h!' do
    subject { described_class.new(dtstart: Time.zone.now) }

    it 'sets the begin and end times to the whole day' do
      subject.open_24h!
      expect(subject.dtstart).to eq Time.zone.now.midnight
      expect(subject.dtend).to eq Time.zone.now.end_of_day
    end
  end

  describe '#update_range' do
    subject { described_class.new(dtstart: Time.zone.now) }

    it 'sets the begin and end times to the given range' do
      subject.update_range(Time.zone.now.midnight..Time.zone.now.noon)
      expect(subject.dtstart).to eq Time.zone.now.midnight
      expect(subject.dtend).to eq Time.zone.now.noon
    end

    it 'sets the end hours to the next day if the end time is before the begin time' do
      subject.update_range(Time.zone.now.noon..Time.zone.now.midnight)
      expect(subject.dtstart).to eq Time.zone.now.noon
      expect(subject.dtend).to eq Time.zone.now.midnight + 1.day
    end
  end

  describe '#update_hours' do
    subject { described_class.new(dtstart: Time.zone.now) }

    it 'parses user input into hour ranges' do
      expect { subject.update_hours('closed') }.to change(subject, :open?).to(false)
      expect { subject.update_hours('open 24h') }.to change(subject, :open_24h?).to(true)
    end

    it 'parses abbreviated times' do
      subject.update_hours('12a-12p')
      expect(subject.dtstart).to eq Time.zone.now.midnight
      expect(subject.dtend).to eq Time.zone.now.noon
    end
  end

  describe '#status_drupal' do
    subject { described_class.new(dtstart: Time.zone.now.localtime) }

    it 'is 0 when the location is closed' do
      subject.closed = true
      expect(subject.status_drupal).to eq 0
    end

    it 'is 1 when the location is open' do
      expect(subject.status_drupal).to eq 1
    end

    it 'is 2 when the location is open 24 hours' do
      subject.dtstart = subject.dtstart.beginning_of_day
      subject.dtend = subject.dtstart.end_of_day
      expect(subject.status_drupal).to eq 2
    end
  end

  describe '#dtend_drupal' do
    subject { described_class.new(dtstart: Time.zone.now.localtime) }

    it 'passes through same-day dtends unchanged' do
      subject.dtend = subject.dtstart.end_of_day
      expect(subject.dtend_drupal).to eq subject.dtend
    end

    it 'moves next-day dtends into the current day' do
      subject.dtend = subject.dtstart.beginning_of_day + 26.hours
      expect(subject.dtend_drupal).to eq subject.dtstart.beginning_of_day + 2.hours
    end
  end
end
