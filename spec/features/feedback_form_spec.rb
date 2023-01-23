# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Feedback form', type: :feature, js: true do
  context 'when not logged in' do
    before do
      visit root_path
    end

    it 'is initially collapsed' do
      expect(page).not_to have_css '#feedback-form.show'
    end

    it 'can be expanded' do
      click_link 'Feedback', match: :first
      expect(page).to have_css '#feedback-form.show'
    end

    it 'can be collapsed' do
      click_link 'Feedback'
      click_link 'Cancel'
      expect(page).not_to have_css '#feedback-form.show'
    end

    it 'shows the reCAPTCHA challenge' do
      click_link 'Feedback'
      expect(page).to have_css('.library-hours-captcha', visible: :all)
    end
  end

  context 'when logged in' do
    before do
      stub_current_user(build(:superadmin_user))
      visit root_path
    end

    it 'does not show the reCAPTCHA challenge' do
      click_link 'Feedback', match: :first
      expect(page).not_to have_css('.library-hours-captcha', visible: :all)
    end

    it 'shows a success alert when submitted' do
      click_link 'Feedback', match: :first
      within 'form.feedback-form' do
        fill_in('message', with: 'This is only a test')
        fill_in('name', with: 'Ronald McDonald')
        fill_in('to', with: 'test@kittenz.eu')
        click_button 'Send'
      end
      expect(page).to have_css('.alert-success', visible: :all)
    end
  end
end
