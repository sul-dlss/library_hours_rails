# frozen_string_literal: true

require 'rails_helper'

describe Location do
  subject { create(:location) }
  let(:term) { create(:term, dtend: 1.year.from_now) }

  describe '#next_open_hours' do
    before do
      subject.term_hours.create(term: term, monday: '9a-12p', tuesday: '9a-12p', wednesday: '9a-12p')
    end

    context 'on a monday' do
      let(:date) { Time.zone.now.at_beginning_of_week }
      let(:next_open) { subject.business_days(date) }
      it 'is the current day' do
        expect(next_open.date).to eq(date.to_date)
      end
    end

    context 'on a wednesday' do
      let(:date) { Time.zone.now.at_end_of_week }
      let(:next_open) { subject.business_days(date) }

      it 'is the next monday' do
        expect(next_open.date).to eq((date.monday + 1.week).to_date)
      end
    end
  end

  describe '#hours' do
    context 'with a term' do
      let(:term) { create(:term, dtstart: Time.zone.parse('2022-06-20').beginning_of_day, dtend: Time.zone.parse('2022-08-12').end_of_day) }

      before do
        subject.term_hours.create(term: term, monday: '9a-12p', tuesday: '10a-1p', wednesday: '11a-2p', thursday: '12p-3p', friday: '1p-4p')
      end

      it 'has the expected hours on the first day of the term' do
        expect(subject.hours(term.dtstart.to_date..term.dtend.to_date)[Date.parse('2022-06-20')].first.dtstart.hour).to eq 9
      end

      it 'has the expected hours on the last day of the term' do
        expect(subject.hours(term.dtstart.to_date..term.dtend.to_date)[Date.parse('2022-08-12')].first.dtstart.hour).to eq 13
      end
    end
  end
end
