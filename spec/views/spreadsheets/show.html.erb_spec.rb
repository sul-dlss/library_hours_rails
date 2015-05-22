require 'rails_helper'

RSpec.describe "spreadsheets/show", type: :view do
  before(:each) do
    @spreadsheet = assign(:spreadsheet, Spreadsheet.create!(
      :attachment_id => "Attachment",
      :attachment_filename => "Attachment Filename",
      :attachment_content_type => "Attachment Content Type",
      :attachment_size => 1,
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Attachment/)
    expect(rendered).to match(/Attachment Filename/)
    expect(rendered).to match(/Attachment Content Type/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Status/)
  end
end
