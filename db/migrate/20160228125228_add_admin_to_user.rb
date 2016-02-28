class AddAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :Admin, :boolean
  end
end
