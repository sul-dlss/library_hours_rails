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
      assert_select 'select#term_hour_term_id[name=?]', 'term_hour[term_id]'

      assert_select 'textarea#term_hour_data[name=?]', 'term_hour[data]'
    end
  end
end
