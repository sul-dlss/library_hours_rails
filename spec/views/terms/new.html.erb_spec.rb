# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'terms/new', type: :view do
  before(:each) do
    assign(:term, Term.new(
                    name: 'MyString'
                  ))
  end

  it 'renders new term form' do
    render

    assert_select 'form[action=?][method=?]', terms_path, 'post' do
      assert_select 'input#term_name[name=?]', 'term[name]'
    end
  end
end
