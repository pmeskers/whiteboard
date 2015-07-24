class AddGcalIdToItem < ActiveRecord::Migration
  def change
    add_column :items, :gcal_event_id, :string
  end
end
