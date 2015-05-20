require 'rails_helper'

RSpec.describe 'locations/edit', type: :view do
  before(:each) do
    @location = assign(:location, Location.create!(
                                    name: 'MyString',
                                    slug: 'MyString',
                                    library: nil
    ))
  end

  it 'renders the edit location form' do
    render

    assert_select 'form[action=?][method=?]', location_path(@location), 'post' do
      assert_select 'input#location_name[name=?]', 'location[name]'

      assert_select 'input#location_slug[name=?]', 'location[slug]'

      assert_select 'input#location_library_id[name=?]', 'location[library_id]'
    end
  end
end
