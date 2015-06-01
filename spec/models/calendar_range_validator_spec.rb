require 'rails_helper'

describe CalendarRangeValidator do
  let(:model) { TermHour.new.tap { |m| allow(m).to receive(:errors).and_return(ActiveModel::Errors.new(m)) } }

  subject { described_class.new(attributes: true) }

  context 'valid data' do
    before do
      expect(model).not_to receive(:errors)
    end

    it 'validates nil' do
      subject.validate_each(model, :monday, nil)
    end

    it 'validates closed' do
      subject.validate_each(model, :monday, 'closed')
    end

    it 'validates open 24 hours' do
      subject.validate_each(model, :monday, 'open 24h')
    end

    it 'validates time ranges' do
      subject.validate_each(model, :monday, '9a-5p')
      subject.validate_each(model, :monday, '1am-12pm')
    end
  end

  context 'invalid data' do
    before do
      expect(model).to receive(:errors)
    end

    it 'requires a time range' do
      subject.validate_each(model, :monday, '9a')
      expect(model.errors.full_messages).to include 'Monday 9a is not a time range'
    end

    it 'requires content' do
      subject.validate_each(model, :monday, '-')
      expect(model.errors.full_messages).to include 'Monday - is not a time range'
    end

    it 'rejects other strings' do
      subject.validate_each(model, :monday, 'this is not a time')
      expect(model.errors.full_messages).to include 'Monday this is not a time is not a time range'
    end
  end
end
