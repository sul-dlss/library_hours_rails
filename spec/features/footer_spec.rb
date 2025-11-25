# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'footer', :js, type: :feature do
  # this is the one difference from the default footer
  # when we update the footer
  # we want to make sure we don't accidently forget to add it back in
  it 'has the staff login in the footer' do
    visit root_path
    within('footer') do
      expect(page).to have_link 'Staff login'
    end
  end
end
