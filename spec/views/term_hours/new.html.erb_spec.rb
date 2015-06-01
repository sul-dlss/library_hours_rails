require 'rails_helper'

RSpec.describe 'term_hours/new', type: :view do
  before(:each) do
    @term_hour = assign(:term_hour, TermHour.new(
                                      term: create(:term),
                                      location: create(:location),
                                      data: 'MyText'
    ))
  end

  it 'renders new term_hour form' do
    render

    assert_select 'form[action=?][method=?]', library_location_term_hours_path(@term_hour.library, @term_hour.location), 'post' do
      assert_select 'input#term_hour_sunday[name=?]', 'term_hour[sunday]'
      assert_select 'input#term_hour_monday[name=?]', 'term_hour[monday]'
      assert_select 'input#term_hour_tuesday[name=?]', 'term_hour[tuesday]'
      assert_select 'input#term_hour_wednesday[name=?]', 'term_hour[wednesday]'
    end
  end
end
