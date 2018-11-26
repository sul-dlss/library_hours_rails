# frozen_string_literal: true

require 'rails_helper'

describe ApplicationHelper do
  let(:at_2pm) do
    Time.zone.parse('2pm')
  end

  let(:at_243am) do
    Time.zone.parse('2:43am')
  end

  describe '#short_time_tag' do
    it 'wraps the time in an HTML5 <time> tag' do
      rendered = helper.short_time_tag(at_2pm)
      expect(rendered).to have_selector 'time', text: '2p'
      expect(rendered).to have_selector 'time[@datetime]'
    end
  end

  describe '#render_short_time' do
    it 'renders only the hours' do
      expect(helper.render_short_time(at_2pm)).to eq '2p'
    end

    it 'renders the minutes if significant' do
      expect(helper.render_short_time(at_243am)).to eq '2:43a'
    end
  end

  describe '#render_open_hours_range' do
    let(:calendar) do
      Calendar.new(dtstart: at_243am, dtend: at_2pm)
    end

    it 'renders the hours with schema.org markup' do
      rendered = helper.render_open_hours_range(calendar)
      expect(rendered).to have_content '2:43a-2p'
      expect(rendered).to have_selector 'time[@itemprop=opens]', text: '2:43a'
      expect(rendered).to have_selector 'time[@itemprop=closes]', text: '2p'
    end
  end

  describe '#render_hours' do
    let(:calendar) do
      Calendar.new(dtstart: at_243am, dtend: at_2pm)
    end

    let(:calendar_closed) do
      Calendar.new(closed: true)
    end

    let(:calendar_24h) do
      Calendar.new(dtstart: Time.zone.now.beginning_of_day, dtend: Time.zone.now.end_of_day)
    end

    let(:calendar_missing) do
      MissingCalendar.new
    end

    it 'renders closed' do
      rendered = helper.render_hours(calendar_closed)
      expect(rendered).to have_selector '.closed', text: 'closed'
    end

    it 'renders open 24 hours' do
      rendered = helper.render_hours(calendar_24h)
      expect(rendered).to have_selector '.open-24h', text: 'open 24h'
    end

    it 'renders n/a when a null calendar is given' do
      rendered = helper.render_hours(calendar_missing)
      expect(rendered).to have_content 'n/a'
    end

    it 'renders the hours range' do
      rendered = helper.render_hours(calendar)
      expect(rendered).to have_content '2:43a-2p'
    end
  end
end
