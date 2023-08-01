# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'locations/edit', type: :view do
  let(:library) { create(:library) }

  before(:each) do
    @location = assign(:location, Location.create!(
                                    name: 'MyString',
                                    slug: 'MyString',
                                    library: library
                                  ))
  end

  it 'renders the edit location form' do
    render

    assert_select 'form[action=?][method=?]', library_location_path(library, @location), 'post' do
      assert_select 'input#location_name[name=?]', 'location[name]'

      assert_select 'input#location_slug[name=?]', 'location[slug]'
    end
  end
end
