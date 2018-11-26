# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TermHour, type: :model do
  describe '#year' do
    it 'extracts the current term year' do
      subject.term = build_stubbed(:term)

      expect(subject.year).to eq 2015
    end
  end
end
