require 'rails_helper'

RSpec.describe 'locations/new', type: :view do
  before(:each) do
    assign(:location, Location.new(
                        name: 'MyString',
                        slug: 'MyString',
                        library: nil
    ))
  end

  it 'renders new location form' do
    render

    assert_select 'form[action=?][method=?]', locations_path, 'post' do
      assert_select 'input#location_name[name=?]', 'location[name]'

      assert_select 'input#location_slug[name=?]', 'location[slug]'

      assert_select 'input#location_library_id[name=?]', 'location[library_id]'
    end
  end
end
