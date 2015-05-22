require 'rails_helper'

RSpec.describe "Spreadsheets", type: :request do
  describe "GET /spreadsheets" do
    it "works! (now write some real specs)" do
      get spreadsheets_path
      expect(response).to have_http_status(200)
    end
  end
end
