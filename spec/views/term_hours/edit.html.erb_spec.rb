require 'rails_helper'

RSpec.describe 'term_hours/edit', type: :view do
  before(:each) do
    @term_hour = assign(:term_hour, TermHour.create!(
                                      term: create(:term),
                                      location: create(:location),
                                      data: 'MyText'
    ))
  end

  it 'renders the edit term_hour form' do
    render

    assert_select 'form[action=?][method=?]', library_location_term_hour_path(@term_hour.library, @term_hour.location, @term_hour), 'post' do
      assert_select 'input#term_hour_sunday[name=?]', 'term_hour[sunday]'
      assert_select 'input#term_hour_monday[name=?]', 'term_hour[monday]'
      assert_select 'input#term_hour_tuesday[name=?]', 'term_hour[tuesday]'
      assert_select 'input#term_hour_wednesday[name=?]', 'term_hour[wednesday]'
    end
  end
end
