# frozen_string_literal: true

require 'rails_helper'

describe Location do
  subject { create(:location) }
  let(:term) { create(:term, dtend: Time.zone.now + 1.year) }

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

  describe '#node_id?' do
    it 'is false if the node_mapping is not set' do
      expect(subject.node_id?).to be_falsey
    end

    it 'is true if there is a node mapping' do
      subject.build_node_mapping(node_id: '5')
      expect(subject.node_id?).to eq true
    end
  end
end
