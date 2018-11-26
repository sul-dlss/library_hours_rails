# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'terms/index', type: :view do
  let(:term) { create(:term) }
  let(:terms) do
    double(quarters_and_intersessions: [term], holidays: [])
  end

  before(:each) do
    assign(:terms, terms)
    allow(view).to receive(:can?).and_return(true)
  end

  it 'renders a list of terms' do
    render
    expect(rendered).to have_selector 'h2', text: '2015'
    expect(rendered).to have_selector 'h3', text: 'MyString 2015-05-27 - 2015-05-27'
  end
end
