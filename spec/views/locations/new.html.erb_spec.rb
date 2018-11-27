# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'locations/new', type: :view do
  let(:library) { create(:library) }

  before(:each) do
    assign(:location, Location.new(
                        name: 'MyString',
                        slug: 'MyString',
                        library: library
                      ))
  end

  it 'renders new location form' do
    render

    assert_select 'form[action=?][method=?]', library_locations_path(library), 'post' do
      assert_select 'input#location_name[name=?]', 'location[name]'

      assert_select 'input#location_slug[name=?]', 'location[slug]'
    end
  end
end
