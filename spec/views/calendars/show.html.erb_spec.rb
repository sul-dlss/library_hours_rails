require 'rails_helper'

RSpec.describe 'calendars/show', type: :view do
  before(:each) do
    @calendar = assign(:calendar, Calendar.create!(
                                    location: '',
                                    summary: 'Summary',
                                    description: 'MyText'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Summary/)
    expect(rendered).to match(/MyText/)
  end
end
