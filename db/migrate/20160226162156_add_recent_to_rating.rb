class AddRecentToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :recent, :boolean
  end
end
