require 'rails_helper'

RSpec.describe 'term_hours/index', type: :view do
  let(:term) { create(:term) }
  let(:location) { create(:location) }

  before(:each) do
    assign(:terms, '2015' => [term])
    assign(:library, location.library)
    assign(:term_hours, [
      TermHour.create!(
        term: term,
        location: location,
        data: 'MyText'
      ),
      TermHour.create!(
        term: term,
        location: location,
        data: 'MyText'
      )
    ])
  end

  it 'renders a list of term_hours' do
    render

    expect(rendered).to have_selector 'h2', text: '2015'
    expect(rendered).to have_selector 'h3', text: 'MyString'
  end
end
