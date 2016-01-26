class RemoveOneClickOptionFromStandup < ActiveRecord::Migration
  def change
    remove_column :standups, :one_click_post
  end
end
