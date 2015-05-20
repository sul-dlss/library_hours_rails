require 'rails_helper'

RSpec.describe 'libraries/index', type: :view do
  before(:each) do
    assign(:libraries, [
      Library.create!(
        name: 'Name',
        slug: 'Slug'
      ),
      Library.create!(
        name: 'Name',
        slug: 'Slug'
      )
    ])
  end

  it 'renders a list of libraries' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Slug'.to_s, count: 2
  end
end
