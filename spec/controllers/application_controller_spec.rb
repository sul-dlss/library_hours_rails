# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController do
  describe '#current_user' do
    before do
      stub_current_user(build(:user))
    end
    
    it 'returns the current user' do
      expect(controller.current_user).to have_attributes id: 'normal-user'
    end
  end

  describe '#current_user?' do
    context 'with a logged in user' do
      before do
        stub_current_user(build(:user))
      end

      it 'is true' do
        expect(controller.current_user?).to be true
      end
    end

    context 'without a logged in user' do
      it 'is false' do
        expect(controller.current_user?).to be false
      end
    end
  end

  describe '#set_range' do
  end
end
