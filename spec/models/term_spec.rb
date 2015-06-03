require 'rails_helper'

RSpec.describe Term, type: :model do
  describe '#year' do
    it 'should extract the year for the term' do
      subject.dtstart = Time.zone.now

      expect(subject.year).to eq Time.zone.now.year
    end
  end
end
