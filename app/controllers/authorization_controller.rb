###
#  Controller for handling login/logout and redirecting with flash messages.
###
class AuthorizationController < ApplicationController
  def login
    flash[:success] = 'You have been successfully logged in.'
    redirect_to params[:referrer] || :back
  end

  def logout
    flash[:notice] = 'You have been successfully logged out.'
    redirect_to params[:referrer] || :back
  end
end
