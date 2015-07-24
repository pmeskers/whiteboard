class RemoveOriginalTitleAndDescriptionFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :original_title, :string
    remove_column :items, :original_description, :string
  end
end
