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

  describe '#primary_location' do
    context 'with a primary location' do
      before do
        subject.locations << primary_location
        subject.locations << build(:location)
      end

      let(:primary_location) { build(:location, primary: true) }

      it 'is the location marked primary' do
        expect(subject.primary_location).to eq primary_location
      end
    end

    context 'without a primary location' do
      before do
        subject.locations << location
      end

      let(:location) { build(:location) }

      it 'is nil' do
        expect(subject.primary_location).to be_nil
      end
    end
  end
end
