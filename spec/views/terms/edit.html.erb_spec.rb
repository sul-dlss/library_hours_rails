# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'terms/edit', type: :view do
  before(:each) do
    @term = assign(:term, Term.create!(
                            name: 'MyString'
                          ))
  end

  it 'renders the edit term form' do
    render

    assert_select 'form[action=?][method=?]', term_path(@term), 'post' do
      assert_select 'input#term_name[name=?]', 'term[name]'
    end
  end
end
