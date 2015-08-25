class IpFencer
  def initialize (authorized_ips)
    @authorized_ips = authorized_ips
  end

  def authorized?(ip_address_string)
    begin
      ip_address = IPAddr.new(ip_address_string)
      return @authorized_ips.any? { |ip| ip.include? ip_address }

    rescue

      Rails.logger.debug "Rescued from exception while authenticating IP: '#{ip_address_string}'"
      return false
    end
  end

  alias_method :includes?, :authorized?
end
