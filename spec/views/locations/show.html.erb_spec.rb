require 'rails_helper'

RSpec.describe 'locations/show', type: :view do
  before(:each) do
    @location = assign(:location, Location.create!(
                                    name: 'Name',
                                    slug: 'Slug',
                                    library: nil
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(//)
  end
end
