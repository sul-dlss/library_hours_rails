# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Edit hours for terms', :js do
  context 'when logged in' do
    let(:location) { create(:location, keeps_hours: true) }
    let(:library) { location.library }

    before do
      create(:term, dtstart: 1.month.from_now, dtend: 3.months.from_now)
      stub_current_user(build(:superadmin_user))
      visit library_path(library)
    end

    it 'updates the hours' do
      click_link 'Edit hours'
      expect(page).to have_content 'Listing Term Hours for'
      within('td.hours:nth-of-type(2)') do
        click_link 'n/a'
        fill_in 'term_hour_sunday', with: '9AM-4PM'
        click_button 'button'
        expect(page).to have_link '9a-4p'
      end
    end
  end
end
