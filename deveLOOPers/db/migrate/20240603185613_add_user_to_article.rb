class AddUserToArticle < ActiveRecord::Migration[7.1]
  def change
    add_reference :articles, :user, foreign_key: true
  end
end
