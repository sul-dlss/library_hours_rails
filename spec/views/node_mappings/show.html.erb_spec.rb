require 'rails_helper'

RSpec.describe 'node_mappings/show', type: :view do
  before(:each) do
    @node_mapping = assign(:node_mapping, NodeMapping.create!(
                                            node_id: 1,
                                            mapped_id: 2,
                                            mapped_type: 'Mapped Type'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Mapped Type/)
  end
end
