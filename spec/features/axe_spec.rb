# frozen_string_literal: true
require 'rails_helper'
require 'axe-rspec'
RSpec.describe 'Accessibility testing', :js do
  # before do
  #   allow(controller).to receive(:current_user).and_return(user)
  # end
  let(:library) { create(:location, keeps_hours: true).library }

  before do
    stub_current_user(build(:superadmin_user))
    create(:library)
    create(:term_hour)
    create(:location)
    create(:term, dtstart: 1.month.from_now, dtend: 3.months.from_now)
  end

  it 'validates the home page' do
    visit root_path
    expect(page).to be_accessible
  end

  it 'validates the individual library page' do
    visit library_path(library)
    expect(page).to be_accessible
  end

  it 'validates the terms page' do
    visit terms_path
    expect(page).to be_accessible
  end

  it 'validates the term page' do
    visit term_path(1)
    expect(page).to be_accessible
  end

  it 'validates the new terms page' do
    visit new_term_path
    expect(page).to be_accessible
  end

  it 'validates the edit terms page' do
    visit edit_term_path(1)
    expect(page).to be_accessible
  end

  it 'validates the spreadsheets page' do
    visit spreadsheets_path
    expect(page).to be_accessible
  end

  it 'validates the new spreadsheets page' do
    visit new_spreadsheet_path
    expect(page).to be_accessible
  end

  it 'validates the new spreadsheets page' do
    visit new_spreadsheet_path
    expect(page).to be_accessible
  end

  it 'validates the spreadsheet libraries page' do
    visit spreadsheet_libraries_path
    expect(page).to be_accessible
  end

  it 'validates the term hours page' do
    visit library_term_hours_path(1)
    expect(page).to be_accessible
  end

  it 'validates the spreadsheet libraries page' do
    visit library_term_hours_path(1)
    expect(page).to be_accessible
  end

  it 'validates the library term hours page' do
    visit library_term_hours_path(1)
    expect(page).to be_accessible
  end

  it 'validates the library term hours page' do
    visit new_library_location_path(1)
    expect(page).to be_accessible
  end

  it 'validates the libraries page' do
    visit new_library_path
    expect(page).to be_accessible
  end

  it 'validates the edit libraries page' do
    visit edit_library_path(1)
    expect(page).to be_accessible
  end

  it 'feedback form' do
    visit feedback_path
    expect(page).to be_accessible
  end

  def be_accessible
    be_axe_clean
  end
end