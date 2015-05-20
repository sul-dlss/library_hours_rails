require 'rails_helper'

RSpec.describe 'node_mappings/index', type: :view do
  before(:each) do
    assign(:node_mappings, [
      NodeMapping.create!(
        node_id: 1,
        mapped_id: 2,
        mapped_type: 'Mapped Type'
      ),
      NodeMapping.create!(
        node_id: 1,
        mapped_id: 2,
        mapped_type: 'Mapped Type'
      )
    ])
  end

  it 'renders a list of node_mappings' do
    render
    assert_select 'tr>td', text: 1.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 'Mapped Type'.to_s, count: 2
  end
end
