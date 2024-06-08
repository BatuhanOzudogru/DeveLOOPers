class AddArticleOwnerIdToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :article_owner_id, :integer
  end
end
