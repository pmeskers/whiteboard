class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  skip_before_filter :calender_events

  def create
    auth = request.env['omniauth.auth']
    token = auth["credentials"]["token"]

    session[:logged_in] = true
    session[:username] = auth['info']['name']
    session[:gcal_token] = token

    redirect_to '/'
  end

  def destroy
    session[:logged_in] = false
  end

  def require_login
  end
end
