class RemoveIpAddressesStringFromStandup < ActiveRecord::Migration
  def change
    remove_column :standups, :ip_addresses_string
  end
end
