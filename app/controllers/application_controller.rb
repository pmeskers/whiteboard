class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :boxed
  before_filter :require_login

  def require_login
    redirect_to '/login' unless session[:logged_in]
  end

  # Adds an outer container element around any yielded HTML.
  # TODO: Get rid of this. We shouldn't toggle an HTML wrapping in the controller.
  def boxed
    @boxed = true
  end
end
