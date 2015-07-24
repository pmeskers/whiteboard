class AddOriginalTitleAndDescriptionToItem < ActiveRecord::Migration
  def change
    add_column :items, :original_title, :string
    add_column :items, :original_description, :string
  end
end
