require 'rails_helper'

RSpec.describe 'spreadsheets/edit', type: :view do
  before(:each) do
    @spreadsheet = assign(:spreadsheet, Spreadsheet.create!(
                                          attachment_id: 'MyString',
                                          attachment_filename: 'MyString',
                                          attachment_content_type: 'MyString',
                                          attachment_size: 1,
                                          status: 'MyString'
    ))
  end

  it 'renders the edit spreadsheet form' do
    render

    assert_select 'form[action=?][method=?]', spreadsheet_path(@spreadsheet), 'post' do
      assert_select 'input#spreadsheet_attachment[name=?]', 'spreadsheet[attachment]'
    end
  end
end
