require 'rails_helper'

RSpec.describe Term, type: :model do
  describe '#year' do
    it 'should extract the year for the term' do
      subject.dtstart = Time.zone.now

      expect(subject.year).to eq Time.zone.now.year
    end
  end

  describe '#terms_cannot_overlap' do
    it 'is not valid if the term overlaps with an existing term' do
      create(:term, dtstart: Date.new(2020, 2, 2), dtend: Date.new(2020, 3, 2))

      t = Term.new(dtstart: Date.new(2020, 2, 15), dtend: Date.new(2020, 4, 15))
      expect(t).not_to be_valid
    end

    it 'is valid if overlaps with itself' do
      t = create(:term, dtstart: Date.new(2020, 2, 2), dtend: Date.new(2020, 3, 2))

      t.dtstart += 5.days
      expect(t).to be_valid
    end
  end
end
