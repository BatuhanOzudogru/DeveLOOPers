class AddStateToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :state, :string, default: "pending"
  end
end
