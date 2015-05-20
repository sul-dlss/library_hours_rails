require 'rails_helper'

RSpec.describe 'calendars/edit', type: :view do
  before(:each) do
    @calendar = assign(:calendar, Calendar.create!(
                                    location: '',
                                    summary: 'MyString',
                                    description: 'MyText'
    ))
  end

  it 'renders the edit calendar form' do
    render

    assert_select 'form[action=?][method=?]', calendar_path(@calendar), 'post' do
      assert_select 'input#calendar_location[name=?]', 'calendar[location]'

      assert_select 'input#calendar_summary[name=?]', 'calendar[summary]'

      assert_select 'textarea#calendar_description[name=?]', 'calendar[description]'
    end
  end
end
