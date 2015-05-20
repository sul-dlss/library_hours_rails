require 'rails_helper'

RSpec.describe 'calendars/index', type: :view do
  before(:each) do
    assign(:calendars, [
      Calendar.create!(
        location: '',
        summary: 'Summary',
        description: 'MyText'
      ),
      Calendar.create!(
        location: '',
        summary: 'Summary',
        description: 'MyText'
      )
    ])
  end

  it 'renders a list of calendars' do
    render
    assert_select 'tr>td', text: ''.to_s, count: 2
    assert_select 'tr>td', text: 'Summary'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end
