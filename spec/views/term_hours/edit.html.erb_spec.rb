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
      assert_select 'select#term_hour_term_id[name=?]', 'term_hour[term_id]'

      assert_select 'textarea#term_hour_data[name=?]', 'term_hour[data]'
    end
  end
end
