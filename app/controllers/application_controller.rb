class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
  before_filter :boxed

  def require_login
    mapper = IpFencer.new(hydrate_ips)
    redirect_to '/login' unless session[:logged_in] || mapper.authorized?(request.remote_ip)
  end

  def boxed
    @boxed = true
  end

  def hydrate_ips
    ips = ENV['IP_WHITELIST'].split(',')

    ips.map do |ip|
      IPAddr.new(ip)
    end
  end
end
