# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Feedback form', type: :feature, js: true do
  before do
    visit root_path
  end

  it 'is initially collapsed' do
    expect(page).not_to have_css('#feedback-form.in')
  end

  it 'can be expanded' do
    click_link 'Feedback', match: :first
    expect(page).to have_css('#feedback-form.in')
  end

  it 'can be collapsed' do
    click_link 'Feedback', match: :first
    find('button.cancel-link').click
    expect(page).not_to have_css('#feedback-form.in')
  end

  context 'when not logged in' do
    it 'shows the reCAPTCHA challenge' do
      click_link 'Feedback', match: :first
      expect(page).to have_css('.library-hours-captcha')
    end
  end

  context 'when logged in' do
    before do
      stub_current_user(build(:superadmin_user))
    end

    it 'does not show the reCAPTCHA challenge' do
      click_link 'Feedback', match: :first
      expect(page).not_to have_css('.library-hours-captcha')
    end

    it 'shows a success message when submitted' do
      click_link 'Feedback', match: :first
      within 'form.feedback-form' do
        fill_in('message', with: 'This is only a test')
        fill_in('name', with: 'Ronald McDonald')
        fill_in('to', with: 'test@kittenz.eu')
        click_button 'Send'
      end
      expect(page).to have_css('.alert-success', text: 'Thank you! Your feedback has been sent.')
    end
  end
end
