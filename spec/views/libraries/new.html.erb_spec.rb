require 'rails_helper'

RSpec.describe 'libraries/new', type: :view do
  before(:each) do
    assign(:library, Library.new(
                       name: 'MyString',
                       slug: 'MyString'
    ))
  end

  it 'renders new library form' do
    render

    assert_select 'form[action=?][method=?]', libraries_path, 'post' do
      assert_select 'input#library_name[name=?]', 'library[name]'

      assert_select 'input#library_slug[name=?]', 'library[slug]'
    end
  end
end
