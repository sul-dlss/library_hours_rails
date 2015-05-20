require 'rails_helper'

RSpec.describe 'node_mappings/edit', type: :view do
  before(:each) do
    @node_mapping = assign(:node_mapping, NodeMapping.create!(
                                            node_id: 1,
                                            mapped_id: 1,
                                            mapped_type: 'MyString'
    ))
  end

  it 'renders the edit node_mapping form' do
    render

    assert_select 'form[action=?][method=?]', node_mapping_path(@node_mapping), 'post' do
      assert_select 'input#node_mapping_node_id[name=?]', 'node_mapping[node_id]'

      assert_select 'input#node_mapping_mapped_id[name=?]', 'node_mapping[mapped_id]'

      assert_select 'input#node_mapping_mapped_type[name=?]', 'node_mapping[mapped_type]'
    end
  end
end
