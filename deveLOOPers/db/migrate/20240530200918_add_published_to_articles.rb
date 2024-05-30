class AddPublishedToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :published, :boolean
  end
end
