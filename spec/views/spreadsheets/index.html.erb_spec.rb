require 'rails_helper'

RSpec.describe "spreadsheets/index", type: :view do
  before(:each) do
    assign(:spreadsheets, [
      Spreadsheet.create!(
        :attachment_id => "Attachment",
        :attachment_filename => "Attachment Filename",
        :attachment_content_type => "Attachment Content Type",
        :attachment_size => 1,
        :status => "Status"
      ),
      Spreadsheet.create!(
        :attachment_id => "Attachment",
        :attachment_filename => "Attachment Filename",
        :attachment_content_type => "Attachment Content Type",
        :attachment_size => 1,
        :status => "Status"
      )
    ])
  end

  it "renders a list of spreadsheets" do
    render
    assert_select "tr>td", :text => "Attachment".to_s, :count => 2
    assert_select "tr>td", :text => "Attachment Filename".to_s, :count => 2
    assert_select "tr>td", :text => "Attachment Content Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
