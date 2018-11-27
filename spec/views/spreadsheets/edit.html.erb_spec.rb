# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'spreadsheets/edit', type: :view do
  let(:tempfile) do
    f = Tempfile.new('xyz')
    f.write('a,b,c')
    f.rewind
    f
  end

  let(:spreadsheet) do
    Spreadsheet.create! do |s|
      s.attachment.attach io: tempfile, filename: 'x.csv', content_type: 'text/plain'
    end
  end

  before(:each) do
    assign(:spreadsheet, spreadsheet)
  end

  it 'renders the edit spreadsheet form' do
    render

    assert_select 'form[action=?][method=?]', spreadsheet_path(spreadsheet), 'post' do
      assert_select 'input#spreadsheet_attachment[name=?]', 'spreadsheet[attachment]'
    end
  end
end
