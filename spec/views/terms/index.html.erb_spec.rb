require 'rails_helper'

RSpec.describe 'terms/index', type: :view do
  let(:term) { create(:term) }
  before(:each) do
    assign(:terms, [
      term
    ])
    allow(view).to receive(:can?).and_return(true)
  end

  it 'renders a list of terms' do
    render
    expect(rendered).to have_selector 'h2', text: '2015'
    expect(rendered).to have_selector 'h3', text: 'MyString 2015-05-27 - 2015-05-27'
  end
end
