class UpdateIndexOnLikes < ActiveRecord::Migration[7.1]
  def change
    remove_index :likes, :user_id
    remove_index :likes, :post_id
    add_index :likes, [:user_id, :post_id], unique: true
  end
end
