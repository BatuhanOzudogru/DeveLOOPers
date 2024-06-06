class AddUserIdToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :user_id, :bigint
    add_foreign_key :comments, :users
    add_index :comments, :user_id
  end
end
