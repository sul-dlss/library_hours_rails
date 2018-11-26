# frozen_string_literal: true

def stub_current_user(user = create(:anon_user))
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
end
