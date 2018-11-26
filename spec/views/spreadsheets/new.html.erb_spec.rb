# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'spreadsheets/new', type: :view do
  before(:each) do
    assign(:spreadsheet, Spreadsheet.new(
                           attachment_id: 'MyString',
                           attachment_filename: 'MyString',
                           attachment_content_type: 'MyString',
                           attachment_size: 1,
                           status: 'MyString'
                         ))
  end

  it 'renders new spreadsheet form' do
    render

    assert_select 'form[action=?][method=?]', spreadsheets_path, 'post' do
      assert_select 'input#spreadsheet_attachment[name=?]', 'spreadsheet[attachment]'
    end
  end
end
