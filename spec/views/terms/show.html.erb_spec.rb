# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'terms/show', type: :view do
  before(:each) do
    @term = assign(:term, create(:term, name: 'Name'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
  end
end
