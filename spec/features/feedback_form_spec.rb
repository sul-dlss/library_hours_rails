# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Feedback form', type: :feature, js: true do

  context 'when not logged in' do
    before(:each) do
      visit root_path
    end

    it 'is initially hidden' do
      expect(page).to have_css('#feedback-form', visible: false)
    end

    it 'can be expanded' do
      click_link 'Feedback', match: :first
      expect(page).to have_css('#feedback-form', visible: true)
    end

    it 'can be collapsed' do
      click_link 'Feedback', match: :first
      find('button.cancel-link').click
      expect(page).to have_css('#feedback-form', visible: false)
    end

    it 'reCAPTCHA challenge is present' do
      click_link 'Feedback', match: :first
      expect(page).to have_css('.library-hours-captcha', visible: false)
    end
  end

  context 'when logged in' do
    before(:each) do
      stub_current_user(build(:superadmin_user))
      visit root_path
    end

    xit 'shows a success message when submitted' do
      click_link 'Feedback', match: :first
      within 'form.feedback-form' do
        fill_in('message', with: 'This is only a test')
        fill_in('name', with: 'Ronald McDonald')
        fill_in('to', with: 'test@kittenz.eu')
        click_button 'Send'
      end
      expect(page).to have_css('.alert-success', text: 'Thank you! Your feedback has been sent.')
    end

    it 'reCAPTCHA challenge is not present' do
      visit root_path
      click_link 'Feedback', match: :first
      expect(page).not_to have_css('.library-hours-captcha', visible: false)
    end
  end
end
