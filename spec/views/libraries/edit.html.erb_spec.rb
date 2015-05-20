require 'rails_helper'

RSpec.describe 'libraries/edit', type: :view do
  before(:each) do
    @library = assign(:library, Library.create!(
                                  name: 'MyString',
                                  slug: 'MyString'
    ))
  end

  it 'renders the edit library form' do
    render

    assert_select 'form[action=?][method=?]', library_path(@library), 'post' do
      assert_select 'input#library_name[name=?]', 'library[name]'

      assert_select 'input#library_slug[name=?]', 'library[slug]'
    end
  end
end
