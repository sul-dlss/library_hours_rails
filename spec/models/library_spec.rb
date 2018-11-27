# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Library, type: :model do
  describe '#sort_key' do
    it 'is 0 (which will sort before alpha) when the configured slug matches' do
      subject.slug = 'green'
      expect(subject.sort_key).to eq '0'
    end

    it 'is the name of the library (so they are sorted alphabetically)' do
      subject.name = 'Library of Fun'
      expect(subject.sort_key).to eq 'Library of Fun'
    end
  end
end
