require 'rails_helper'

RSpec.describe 'locations/index', type: :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        name: 'Name',
        slug: 'Slug',
        library: nil
      ),
      Location.create!(
        name: 'Name',
        slug: 'Slug',
        library: nil
      )
    ])
  end

  it 'renders a list of locations' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Slug'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
