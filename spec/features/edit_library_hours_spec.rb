# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Edit library hours', :js do
  context 'when logged in' do
    let(:library) { create(:location, keeps_hours: true).library }

    before do
      stub_current_user(build(:superadmin_user))
      visit library_path(library)
    end

    it 'updates the hours' do
      within('td.hours:nth-of-type(2)') do
        click_link 'n/a'
        fill_in 'date_time', with: '9AM-4PM'
        click_button 'button'
        expect(page).to have_link '9a-4p'
      end
    end
  end
end
