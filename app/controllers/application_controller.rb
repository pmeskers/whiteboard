class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

  def require_login
    if ENV['IP_WHITELIST']
      mapper = IpFencer.new(hydrate_ips)
      redirect_to '/login' unless session[:logged_in] || mapper.authorized?(request.remote_ip)
    else
      redirect_to '/login' unless session[:logged_in]
    end
  end

  def hydrate_ips
    ips = ENV['IP_WHITELIST'].split(',')

    ips.map do |ip|
      begin
        addr = IPAddr.new(ip)
      rescue
        puts "SKIPPING INVALID IP: #{ip}"
        next
      end
      addr
    end
  end
end
