# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Term, type: :model do
  subject { build(:term) }
  describe 'validation' do
    it 'validates the dtstart + dtend times' do
      subject.dtstart = Date.new(2014, 2, 2)
      subject.dtend = Date.new(2015, 2, 2)
      expect(subject).to be_valid
    end

    it 'transforms the dtstart + dtend values from strings to times' do
      subject.dtstart = '2014-02-02'
      subject.dtend = '2014-03-02'
      expect(subject).to be_valid
    end

    it 'handles invalid dates' do
      subject.dtstart = '2020-03029'
      subject.dtend = Date.new(2015, 2, 2)
      expect(subject).not_to be_valid
    end
  end

  describe '#year' do
    it 'should extract the year for the term' do
      subject.dtstart = Time.zone.now

      expect(subject.year).to eq Time.zone.now.year
    end
  end

  describe '#terms_cannot_overlap' do
    it 'is not valid if the term overlaps with an existing term' do
      create(:term, dtstart: Date.new(2020, 2, 2), dtend: Date.new(2020, 3, 2))

      t = build(:term, dtstart: Date.new(2020, 2, 15), dtend: Date.new(2020, 4, 15))
      expect(t).not_to be_valid
    end

    it 'is not valid if the term overlaps with an existing term' do
      create(:term, dtstart: Date.new(2020, 2, 2), dtend: Date.new(2020, 3, 2))

      t = build(:term, dtstart: Date.new(2020, 1, 1), dtend: Date.new(2020, 2, 5))
      expect(t).not_to be_valid
    end

    it 'is valid if overlaps with itself' do
      t = create(:term, dtstart: Date.new(2020, 2, 2), dtend: Date.new(2020, 3, 2))

      t.dtstart += 5.days
      expect(t).to be_valid
    end
  end

  describe '.holiday?' do
    it 'checks if a given date overlaps with a holiday' do
      create(:holiday, dtstart: Date.new(2015, 2, 2).to_time.beginning_of_day,
                       dtend: Date.new(2015, 2, 2).to_time.end_of_day)

      expect(Term.holiday?(Date.new(2015, 2, 2))).to eq true

      expect(Term.holiday?(Date.new(2015, 2, 1))).to eq false
      expect(Term.holiday?(Date.new(2015, 2, 3))).to eq false
    end
  end
end
