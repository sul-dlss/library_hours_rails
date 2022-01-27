# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Feedback form', type: :feature, js: true do

  it 'is initially hidden' do
    visit root_path
    expect(page).to have_css('form.feedback-form', visible: :hidden)
  end

  it 'can be expanded' do
    visit root_path
    click_link 'Feedback', match: :first
    expect(page).to have_css('form.feedback-form', visible: :visible)
  end

  it 'can be collapsed' do
    visit root_path
    click_link 'Feedback', match: :first
    find('button.cancel-link').click
    expect(page).to have_css('form.feedback-form', visible: :hidden)
  end

  it 'shows a success message when submitted' do
    visit root_path
    click_link 'Feedback', match: :first
    within 'form.feedback-form' do
      fill_in('message', with: 'This is only a test')
      fill_in('name', with: 'Ronald McDonald')
      fill_in('to', with: 'test@kittenz.eu')
      click_button 'Send'
    end
    expect(page).to have_css('div.alert-success', text: 'Thank you! Your feedback has been sent.')
  end

  context 'when not logged in' do
    it 'reCAPTCHA challenge is present' do
      visit root_path
      expect(page).to have_css '.library-hours-captcha'
    end
  end

  context 'when logged in' do
    it 'reCAPTCHA challenge is not present' do
      visit feedback_path
      expect(page).not_to have_css '.library-hours-captcha'
    end
  end
end
