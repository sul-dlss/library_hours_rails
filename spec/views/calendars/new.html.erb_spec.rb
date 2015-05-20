require 'rails_helper'

RSpec.describe 'calendars/new', type: :view do
  before(:each) do
    assign(:calendar, Calendar.new(
                        location: '',
                        summary: 'MyString',
                        description: 'MyText'
    ))
  end

  it 'renders new calendar form' do
    render

    assert_select 'form[action=?][method=?]', calendars_path, 'post' do
      assert_select 'input#calendar_location[name=?]', 'calendar[location]'

      assert_select 'input#calendar_summary[name=?]', 'calendar[summary]'

      assert_select 'textarea#calendar_description[name=?]', 'calendar[description]'
    end
  end
end
